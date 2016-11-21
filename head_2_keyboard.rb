#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'
require 'json'


#
# this is the script for the twitter bot head_2_keyboard
# generated on 2016-11-21 10:44:11 -0500
#


@keyboards = JSON.parse(File.read("keyboards.json"))
@state = "default"
@key = @keyboards[@state].sample.sample
@count = rand(1..8)


output = []

def index_of(val)
  b = @keyboards[@state]
  y = 0
  b.each { |r|
    if r.index(val)
      return r.index(val), y
    end
    y = y + 1
  }
end

def neighbors(val, dist=2)
  x, y = index_of(val)
  result = []
  (-dist+y..dist+y).each { |yd|
    
    if yd >= 0 && yd < @keyboards[@state].length
      row = @keyboards[@state][yd]
      (-dist..dist).each { |xd|
        if xd >= 0 && xd < row.length
          result << row[xd]
        end
      }
    end
  }
  result
end

1.upto(@count) do
  amount = rand(3..20)
  1.upto(amount) do 
    keys = neighbors(@key)
    @key = keys.sample
    if @key == ":shift:"
      @state = (@state == "default" ? "caps" : "default")
    else
      output << @key
    end
  end
  output << " "
end

tweet output.join("")

