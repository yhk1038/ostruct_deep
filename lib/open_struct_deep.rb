require "open_struct_extend/version"
require 'ostruct'

class OpenStructDeep < OpenStruct
  def initialize(hash=nil)
    @table = {}
    if hash
      hash.each_pair do |k, v|
        k = k.to_sym
        v = OpenStructDeep.new v if v.is_a? Hash
        v = v.map { |x| OpenStructDeep.new x } if v.is_a? Array
        @table[k] = v
      end
    end
  end
end
