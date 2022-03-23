require "action_controller"
require "stringio"

Mime::Type.register "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :xlsx

ActionController::Renderers.add :xlsx do |data, options|
  # force layout false
  options[:layout] = false
  # disposition / filename
  options[:disposition] = options.delete(:disposition) || "attachment"

  options[:filename] ||= if defined?(ActiveRecord) && data.is_a?(ActiveRecord::Relation)
    "#{data.klass.model_name.human}_#{Time.now.to_i}"
  else
    Time.now.to_i.to_s
  end

  options[:filename] = options[:filename] ? options[:filename].strip.sub(/\.xlsx$/i, "") : "data"

  headers["Content-Type"] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  headers["Content-disposition"] = "attachment; filename=\"#{options[:filename]}.xlsx\""
  headers["X-Accel-Buffering"] = "no"
  headers["Cache-Control"] = "no-cache"
  headers["Last-Modified"] = Time.zone.now.ctime.to_s
  headers.delete("Content-Length")
  self.response_body = Enumerator.new do |enumerator|
    xlsx = Xlsxtream::Workbook.new(enumerator)
    if lookup_context.template_exists?(options[:template], options[:prefixes])
      source = lookup_context.find_template(options[:template], options[:prefixes], false).source
      builder = StringIO.new
      builder << "# encoding: utf-8\n"
      builder << source
      view_context.instance_eval(builder.string)
    else
      XlsxtreamRails::Utils.write_xls(xlsx, data)
    end

    xlsx.close
  end
end

# For respond_to default
begin
  ActionController::Responder
rescue
else
  class ActionController::Responder
    def to_xlsx
      @_action_has_layout = false
      if @default_response
        @default_response.call(options)
      else
        controller.render({xlsx: controller.action_name}.merge(options))
      end
    end
  end
end
