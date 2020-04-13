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

def find_files(command)
  return Dir[__dir__ + '/*.py'], __dir__ if command.size.zero?

  return Dir[command[0] + '/*.py'], command[0] if command[0] != '-r'

  return Dir[command[1] + '/*.rb'], command[1] if command[0] == '-r'
end

def read_file(file)
  file_data = []
  File.foreach(file) { |line| file_data << line }
  file_data
end

files, directory = find_files(ARGV)
extension = files[0]['.rb'].nil? ? '.py' : '.rb'
files.each do |file|
  file_data = read_file(file)
  puts 'File: '.green.bold + file.sub!(directory, '').bold
  puts Linter.check_rules(extension, file_data)
  puts
end
