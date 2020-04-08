require_relative "string.rb"

class CheckRule
  def self.line_terminator(file_data)
    if file_data[-1][-1] == "\n"
      false
    else
      rule ='rule: there should be a line terminator on last line' 
      location = "line: #{file_data.size} col: #{file_data[-1].size}".red 
      puts location + ' ' + rule
      return [location, rule]
    end
  end

  def self.identation(file_data)
    result_identation = []
    file_data.each_with_index do |line, i|
      puts line.green
      if !line[/\A\t*/].size.zero?
        rule ='rule: use spaces instead of tabs' 
        location = "line: #{i} col: #{1}".red 
        puts location + ' ' + rule
        result_identation << [location, rule]
      end
      if !line[/ *\z/].chomp.size.zero?
        rule ='rule: erase unnecesary spaces before line terminator' 
        location = "line: #{i} col: #{line.size}".red 
        puts location + ' ' + rule
        result_identation << [location, rule]
      end
      if !line[/\A */].size.zero?
        puts "identation #{line[/\A */].size}"
      end
    end
    return result_identation
  end
end