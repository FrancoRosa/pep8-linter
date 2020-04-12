# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

require_relative 'colors.rb'
require_relative 'features.rb'

class Linter
  @max_line_length = 79
  @indentation = 4

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

  def self.indentation_tabs(line, index)
    location = "line: #{index + 1}, col: 1: ".red
    rule = 'rule: use spaces instead of tabs'
    location + rule if line.indentation_with_tabs.nonzero?
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

  def self.different_indentation(line_indentation, diff_indentation, index)
    location = "line: #{index + 1}, col: #{line_indentation}: ".red
    rule = "rule: indentation should use #{@indentation} spaces"
    location + rule if diff_indentation != @indentation
  end

  def self.unspected_indentation(line_indentation, index)
    location = "line: #{index + 1}, col: #{line_indentation}: ".red
    rule = 'rule: unexpected indentation'
    location + rule
  end

  def self.newline_symbol(line_indentation, index)
    location = "line: #{index + 1}, col: #{line_indentation}: ".red
    rule = "rule: indentation should not use #{@indentation} spaces"
    location + rule
  end

  def self.indentation_rules(line, pre_line, index)
    broken_rules = []
    pre_indentation = pre_line.indentation
    line_indentation = line.indentation
    diff_indentation = line_indentation - pre_indentation
    if diff_indentation.positive? and (pre_line.end_colon? or pre_line.class_key? or pre_line.def_key?)
      unless different_indentation(line_indentation, diff_indentation, index).nil?
        broken_rules << different_indentation(line_indentation, diff_indentation, index)
      end
    elsif pre_line.end_new_line_symbol? or pre_line.end_key?
      newline_symbol(line_indentation, index)
    elsif diff_indentation.nonzero?
      broken_rules << unspected_indentation(line_indentation, index)
    end
    broken_rules
  end

  def self.inline_rules(line, index)
    broken_rules = []
    broken_rules << indentation_tabs(line, index) unless indentation_tabs(line, index).nil?
    broken_rules << spaces_before_terminator(line, index) unless spaces_before_terminator(line, index).nil?
    broken_rules << useless_semicolon(line, index) unless useless_semicolon(line, index).nil?
    broken_rules << line_length(line, index) unless line_length(line, index).nil?
    broken_rules
  end

  def self.check_rules(extension, lines)
    @indentation = 2 unless extension['.rb'].nil?
    broken_rules = []
    lines.each_with_index do |line, i|
      pre_line = i.positive? ? lines[i - 1] : ''
      broken_rules << inline_rules(line, i) unless inline_rules(line, i).size.zero?
      if line.indentation.nonzero? and !indentation_rules(line, pre_line, i).size.zero?
        broken_rules << indentation_rules(line, pre_line, i)
      end
    end
    broken_rules << line_terminator(lines) unless line_terminator(lines).nil?
    broken_rules
  end
end
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
