require_relative "colors.rb"
require_relative "features.rb"

# def identation_with_tabs(line)
#   line[/\A\t*/].size
# end


class CheckRule 
  def self.line_terminator(file_data)
    if file_data[-1][-1] != "\n"
      location = "line: #{file_data.size} col: #{file_data[-1].size} : ".red 
      rule ='rule: there should be a line terminator on last line' 
      return location + rule
    end
  end

  def self.features(lines)
    identation_size = 4
    result_identation = []
    lines.each_with_index do |line, i|
      print line.green
      if line.identation_with_tabs.nonzero?
        location = "line: #{i} col: #{1} : ".red 
        rule ='rule: use spaces instead of tabs' 
        result_identation << location + rule
      end
      if line.spaces_before_terminator.nonzero?
        location = "line: #{i} col: #{line.size} : ".red 
        rule ='rule: erase unnecesary spaces before line terminator' 
        result_identation << location + rule
      end
      if line.identation.nonzero?
        if i.zero?
          rule = "rule: you shoud not start with identation" 
          location = "line: #{i} col: #{1} : ".red
          result_identation << location + rule
        else
          last_identation = lines[i-1].identation
          current_identation = line.identation
          if last_identation - current_identation != identation_size
            location = "line: #{i} col: #{1} : ".red
            rule = "rule: identation should use #{identation_size} spaces" 
            result_identation << location + rule
          end
        end
      end
    end
    return result_identation
  end
end