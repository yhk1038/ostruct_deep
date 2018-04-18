require_relative '../ostruct_deep/open_struct_deep'

class Hash
  def to_ostruct_deep
    OpenStructDeep.new self
  end
  
  def symbolize_keys
    transform_keys{ |key| key.to_sym rescue key }
  end

  def transform_keys
    return enum_for(:transform_keys) unless block_given?
    result = self.class.new
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end
end