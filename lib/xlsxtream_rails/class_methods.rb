module XlsxtreamRails
  module ClassMethods
    # TODO
    def to_xlsx
      column_names.map { |x| x.to_sym }
    end
  end
end
