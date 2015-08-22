module StringUtils

  def underscore(string)
    string.downcase.gsub(/\s/, "_").to_sym
  end

end
