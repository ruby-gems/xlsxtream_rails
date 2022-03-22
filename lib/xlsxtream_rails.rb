require "xlsxtream"
require "xlsxtream_rails/utils"
require "xlsxtream_rails/version"
require "xlsxtream_rails/railtie"

module XlsxtreamRails
  def xlsx_columns(opts = {})
    column_names = self.class.column_names
    column_names.map { |x| x.to_sym }
  end
end
