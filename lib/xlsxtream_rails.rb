require "xlsxtream"
require "xlsxtream_rails/class_methods"
require "xlsxtream_rails/utils"
require "xlsxtream_rails/version"
require "xlsxtream_rails/railtie"

module XlsxtreamRails
  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  def xlsx_columns(opts = {})
    self.class.to_xlsx
  end
end
