# encoding: utf-8

class Hash # :nodoc:
  def symbolize_keys  # :nodoc:
    inject({}) do |hash, (key, value)|
      hash[(key.to_sym rescue key) || key] = value
      hash
    end
  end unless method_defined?(:symbolize_keys)

  def symbolize_keys! # :nodoc:
    hash = symbolize_keys
    hash.each do |key, val|
      hash[key] = case val
        when Hash
          val.symbolize_keys!
        when Array
          val.map do |item|
            item.is_a?(Hash) ? item.symbolize_keys! : item
          end
        else
          val
        end
    end
    return hash
  end unless method_defined?(:symbolize_keys!)

  def extractable_options?
    instance_of?(Hash)
  end unless method_defined?(:extractable_options?)
end # Hash
