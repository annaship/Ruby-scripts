#!/usr/bin/ruby -p

while $stdin.gets                        # reads from STDIN
    unless (/\d/) 
        $stderr.puts "No digit found."   # writes to STDERR
    end
    puts "Read: #{$_}"                   # writes to STDOUT
end
