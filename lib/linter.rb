require_relative 'colors.rb'
require_relative 'features.rb'

class Linter
  @identation = 4
  @max_line_length = 79

  def self.line_terminator(file_data)
    location = "line: #{file_data.size}, col: #{file_data[-1].size}: ".red
    rule = 'rule: there should be a line terminator on last line'
    location + rule if file_data[-1][-1] != "\n"
  end

  def self.line_length(line, index)
    location = "line: #{index + 1}, col: #{@max_line_length}: ".red
    rule = "rule: size of line should be less than #{@max_line_length}"
    location + rule if line.size > @max_line_length
  end

  def self.identation_tabs(line, index)
    location = "line: #{index + 1}, col: 1: ".red
    rule = 'rule: use spaces instead of tabs'
    location + rule if line.identation_with_tabs.nonzero?
  end

  def self.spaces_before_terminator(line, index)
    location = "line: #{index + 1}, col: #{line.size}: ".red
    rule = 'rule: erase unnecessary spaces before line terminator'
    location + rule if line.spaces_before_terminator.nonzero?
  end

  def self.useless_semicolon(line, index)
    location = "line: #{index + 1}, col: #{line.size}: ".red
    rule = 'rule: semi colons are unnecessary'
    location + rule if line.end_semi_colon?
  end

  def self.different_identation(line_identation, diff_identation, index)
    location = "line: #{index + 1}, col: #{line_identation}: ".red
    rule = "rule: indentation should use #{@identation} spaces"
    location + rule if diff_identation != @identation
  end

  def self.unspected_identation(line_identation, index)
    location = "line: #{index + 1}, col: #{line_identation}: ".red
    rule = 'rule: unexpected indentation'
    location + rule
  end

  def self.newline_symbol(line_identation, index)
    location = "line: #{index + 1}, col: #{line_identation}: ".red
    rule = "rule: indentation should not use #{@identation} spaces"
    location + rule
  end

  def self.identation_rules(line, pre_line, index)
    broken_rules = []
    pre_identation = pre_line.identation
    line_identation = line.identation
    diff_identation = line_identation - pre_identation
    if diff_identation.positive? and pre_line.end_colon?
      unless different_identation(line_identation, diff_identation, index).nil?
        broken_rules << different_identation(line_identation, diff_identation, index)
      end
    elsif pre_line.end_new_line_symbol?
      newline_symbol(line_identation, index)
    elsif diff_identation.nonzero?
      broken_rules << unspected_identation(line_identation, index)
    end
    broken_rules
  end

  def self.inline_rules(line, index)
    broken_rules = []
    broken_rules << identation_tabs(line, index) unless identation_tabs(line, index).nil?
    broken_rules << spaces_before_terminator(line, index) unless spaces_before_terminator(line, index).nil?
    broken_rules << useless_semicolon(line, index) unless useless_semicolon(line, index).nil?
    broken_rules << line_length(line, index) unless line_length(line, index).nil?
    broken_rules
  end

  def self.check_rules(lines)
    broken_rules = []
    lines.each_with_index do |line, i|
      pre_line = i.positive? ? lines[i - 1] : ''
      broken_rules << inline_rules(line, i) unless inline_rules(line, i).size.zero?
      if line.identation.nonzero? and !identation_rules(line, pre_line, i).size.zero?
        broken_rules << identation_rules(line, pre_line, i)
      end
    end
    broken_rules << line_terminator(lines) unless line_terminator(lines).nil?
    broken_rules
  end
end
