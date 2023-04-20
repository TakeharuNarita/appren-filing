require 'json'

class Aa
  def self.inst
    @inst
  end
  def self.inst= (inst)
    @inst = inst
  end

  attr_accessor :date

  def initialize
  end
end

obj = Aa.new
data = obj.to_json
p data
obj = JSON.parse(data, object_class: Aa)

p obj
