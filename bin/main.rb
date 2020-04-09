#! /usr/bin/ruby

require_relative '../lib/check_rule.rb'
require_relative '../lib/colors.rb'
require_relative '../lib/features.rb'

def find_py_files(directories)
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

files = find_py_files(ARGV)
files.each do |file| 
  puts file.bold
  file_data = read_file(file)
  puts CheckRule.features(file_data)
  puts CheckRule.line_terminator(file_data)
end
