module XlsxtreamRails
  module Utils
    def self.write_xls(xlsx, data)
      headers = []
      needs_headers = true
      needs_column_types = false
      xlsx.write_worksheet(auto_format: false) do |sheet|
        data.find_each do |instance, index|
          row_data = []
          instance_cols = instance.xlsx_columns
          instance_cols.each_with_index do |x, i|
            if x.is_a?(Array)
              headers.push(i18n_attr(instance, x[0])) if needs_headers
              row_data.push(x[1].is_a?(Symbol) ? instance.send(x[1]) : x[1])
              if needs_column_types
                column_types[i] = x[2]
              end
            else
              headers.push(i18n_attr(instance, x)) if needs_headers
              row_data.push(x.is_a?(Symbol) ? instance.send(x) : x)
            end
          end
          sheet.add_row headers if needs_headers
          needs_headers = false
          sheet.add_row row_data
        end
      end
    end

    def self.i18n_attr(instance, attr)
      attr = attr.is_a?(Symbol) ? attr : attr.to_sym
      instance.class.human_attribute_name(attr)
    end
  end
end
