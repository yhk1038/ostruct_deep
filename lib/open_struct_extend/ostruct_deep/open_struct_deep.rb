require 'ostruct'

class OpenStructDeep < OpenStruct
  
  def initialize(hash=nil)
    @table = {}
    if hash
      hash.each_pair do |k, v|
        k = k.to_sym
        v = case v
            when Hash
              OpenStructDeep.new v
            when Array
              v.map { |x| x.is_a?(Hash) ? OpenStructDeep.new(x) : x }
            else
              v
            end
        @table[k] = v
      end
    end
  end
  
  def to_h
    {}.tap do |dup|
      @table.dup.each { |k, v| dup[k] = map_value(v) }
    end
  end
  
  private
  
  def map_value(thing)
    case thing
    when OpenStructDeep then thing.to_h
    when Array          then thing.map { |v| map_value(v) }
    else thing
    end
  end
  
end