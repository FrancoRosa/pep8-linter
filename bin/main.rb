#! /usr/bin/ruby

require_relative '../lib/check_rule.rb'

def find_files(directories)
  if directories.size.zero?
    return Dir[__dir__ + '/*.py']

  else
    return Dir[directories[0] + '/*.py']
  
  end
end

def read_file(file)
  file_data = []
  File.foreach(file) { |line| file_data << line}
  return file_data
end

#############################################
files = find_files(ARGV)
files.each do |k| 
  puts 
  puts 
  puts "## #{k} ##"
  z = read_file(k)
  puts "## lines: #{z.size} ##"
  puts z
  puts 
  puts "####### Line identation ###########"
  CheckRule.identation(z)
  puts "####### Line terminator ###########"
  CheckRule.line_terminator(z)
  puts 
end

