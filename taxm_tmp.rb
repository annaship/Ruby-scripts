#!/usr/bin/ruby

require "rubygems"
require "taxamatch_rb"

# list = [ARGV[0].to_s, ARGV[1].to_s]
# a = list[0]
# b = list[1]

# list = ["sandersoni", "sajidersoni"]


# def my_taxam(n, m)
  # puts n
  # puts m
  t = Taxamatch::Base.new
  puts t.taxamatch("sandersoni", "sandersoni")
  # then  
  #     puts "URA"
  #   # return Taxamatch::Base.new.taxamatch(a, b)
  #   #   puts "true"
  #   else
  #     puts "false"
  #   end
# end
# 
# puts my_taxam("sandersoni", "sandersoni")

