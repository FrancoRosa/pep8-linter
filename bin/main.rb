#! /usr/bin/ruby

require_relative '../lib/linter.rb'
require_relative '../lib/colors.rb'
require_relative '../lib/features.rb'

def find_py_files(directories)
  if directories.size.zero?
    Dir[__dir__ + '/*.py']
  else
    Dir[directories[0] + '/*.py']
  end
end

def read_file(file)
  file_data = []
  File.foreach(file) { |line| file_data << line }
  file_data
end

files = find_py_files(ARGV)
files.each do |file|
  file_data = read_file(file)
  puts 'File: '.green.bold + file.sub!(ARGV[0], '').bold
  puts Linter.check_rules(file_data)
  puts
end
