#!/usr/bin/env ruby
n = gets.to_i
a = gets.split.map &:to_i
puts a.inject :+
puts a.max
