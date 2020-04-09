#! /usr/bin/ruby

require_relative '../lib/check_rule.rb'
require_relative '../lib/colors.rb'
require_relative '../lib/features.rb'

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

def test_def(input)
  puts input
end


####################################
#############################################
files = find_files(ARGV)
files.each do |file| 
  puts 
  puts 
  puts file.bold
  file_data = read_file(file)
  CheckRule.identation(file_data)
  CheckRule.line_terminator(file_data)
  puts 
end
