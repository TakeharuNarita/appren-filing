# frozen_string_literal: true

# @param none
module CamelSnakeResolver
  def camel(snake)
    becamel = snake.to_s.gsub(/_(.)/) { Regexp.last_match(1).upcase }
    becamel.slice(0).upcase! + becamel.slice(1..)
  end

  def snake(camel)
    camel.to_s.gsub(/([A-Z])/) { "_#{Regexp.last_match(1).downcase}" }.slice(1..)
  end
end
