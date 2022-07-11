module XlsxtreamRails
  module ClassMethods
    def to_xlsx
      except_columns = respond_to?(:xlsx_except_columns) ? xlsx_except_columns : []
      (column_names - except_columns).map { |x| x.to_sym }
    end
  end
end
