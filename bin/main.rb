#! /usr/bin/ruby

require_relative '../lib/linter.rb'
require_relative '../lib/colors.rb'
require_relative '../lib/features.rb'

def find_py_files(directories) #rb or py
  if directories.size.zero?
    Dir[__dir__ + '/*.py'] 
  else
    Dir[directories[0] + '/*.py']
  end
end

def find_files(command) #rb or py
  #
  # file_path
  # -r file_path
  puts ">>>>>>estension: " + command.inspect
  if command.size.zero?
    linter = Linter.new(4)
    return Dir[__dir__ + '/*.py'], __dir__ 
  elsif command[0] != '-r'
    return Dir[command[0] + '/*.py'], command[0]
  else
    return Dir[command[1] + '/*.rb'], command[1]
  end
end

def read_file(file)
  file_data = []
  File.foreach(file) { |line| file_data << line }
  file_data
end

#files = find_py_files(ARGV)
files, directory = find_files(ARGV)
extension = files[0]['.rb'].nil? ? '.py': '.rb'
files.each do |file|
  file_data = read_file(file)
  puts 'File: '.green.bold + file.sub!(directory, '').bold
  puts Linter.check_rules(extension,file_data)
  puts
end
