require "action_view"
require "stringio"

module ActionView
  module Template::Handlers
    class XrbBuilder
      def default_format
        Mime[:xlsx].symbol
      end

      def call(template, source = nil)
        builder = StringIO.new
        builder << "# encoding: utf-8\n"
        builder << (source || template.source)
        builder.string
      end
    end
  end
end
