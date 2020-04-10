require_relative 'colors.rb'
require_relative 'features.rb'

class CheckRule
  def self.line_terminator(file_data)
    location = "line: #{file_data.size}, col: #{file_data[-1].size}: ".red
    rule = 'rule: there should be a line terminator on last line'
    location + rule if file_data[-1][-1] != "\n"
  end

  def self.identation_tabs(line, index)
    location = "line: #{index + 1}, col: 1: ".red
    rule = 'rule: use spaces instead of tabs'
    location + rule if line.identation_with_tabs.nonzero?
  end

  def self.spaces_before_terminator(line, index)
    location = "line: #{index + 1}, col: #{line.size}: ".red
    rule = 'rule: erase unnecesary spaces before line terminator'
    location + rule if line.spaces_before_terminator.nonzero?
  end

  def self.useless_semicolon(line, index)
    location = "line: #{index + 1}, col: #{line.size}: ".red
    rule = 'rule: semi colons are unnecesary'
    location + rule if line.end_semi_colon?
  end

  def self.features(lines)
    identation_size = 4
    result_identation = []
    lines.each_with_index do |line, i|

      previous_line = lines[i - 1] if i.positive?
      result_identation << identation_tabs(line, i) unless identation_tabs(line, i).nil?
      result_identation << spaces_before_terminator(line, i) unless spaces_before_terminator(line, i).nil?
      result_identation << useless_semicolon(line, i) unless useless_semicolon(line, i).nil?

      if line.identation.nonzero?
        last_identation = lines[i - 1].identation
        current_identation = line.identation
        diference_identation = current_identation-last_identation
        if diference_identation.positive? and lines[i-1].end_colon?
          if diference_identation != identation_size
            location = "line: #{i + 1}, col: #{current_identation}: ".red
            rule = "rule: identation should use #{identation_size} spaces" 
            result_identation << location + rule
          end
        else
          if lines[i-1].end_new_line_symbol?
            location = "line: #{i+1}, col: #{current_identation}: ".red
            rule = "rule: identation should not use #{identation_size} spaces"
            result_identation << location + rule
          elsif diference_identation.nonzero?
            location = "line: #{i+1}, col: #{current_identation}: ".red
            rule = "rule: unspected identation"
            result_identation << location + rule
          end
        end
      end
    end
    result_identation
  end
end