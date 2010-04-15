#!/usr/bin/ruby

out = nil

  puts ARGV.size
  puts "ARGV[0] = "+ARGV[0]
  puts "ARGV[1] = "+ARGV[1]
  # puts ARGV.slice!(-1,1)[0]
    # ARGV.each do |a|
    #   puts a
    # end
    
case ARGV.size
  when 0, 1
    out = $stdout
  else
    out = File.open( ARGV.slice!(-1,1)[0], "w" )
end

begin
  while line = gets
    line.chomp!
    out.puts line.reverse
  end
ensure
  out.close unless out.equal? $stdout
end
