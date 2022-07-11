module XlsxtreamRails
  module ClassMethods
    # TODO
    def to_xlsx
      (column_names - except_xlsx_columns).map { |x| x.to_sym }
    end

    def except_xlsx_columns
      []
    end
  end
end
