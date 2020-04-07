#! /usr/bin/ruby
files = ARGV
if ARGV.size == 0
  puts "...look for files in directory"
else
  for f in files do
    puts f
  end
end