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
              headers.push(x[0].to_s) if needs_headers
              row_data.push(x[1].is_a?(Symbol) ? instance.send(x[1]) : x[1])
              if needs_column_types
                column_types[i] = x[2]
              end
            else
              headers.push(str_titleize(x.to_s)) if needs_headers
              row_data.push(x.is_a?(Symbol) ? instance.send(x) : x)
            end
          end
          sheet.add_row headers if needs_headers
          needs_headers = false
          sheet.add_row row_data
        end
      end
    end

    def self.str_titleize(str)
      str.sub(/\A_+/, "")
        .gsub(/[_.]/, " ")
        .sub(" rescue nil", "")
        .gsub(/(\A|\ )\w/) { |x| x.upcase }
    end
  end
end
