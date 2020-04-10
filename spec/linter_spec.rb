require_relative '../lib/linter.rb'

RSpec.describe Linter do
  describe '#line_terminator' do
    it 'returns nil if there is an eol on file' do
      file_data = [["code code \n"],
                   ["code code\n"]]
      expect(Linter.line_terminator(file_data).nil?).to be false
    end

    it 'returns a message if there is no an eol on file' do
      file_data = [["code code \n"],
                   ['code code']]
      expect(Linter.line_terminator(file_data).nil?).to be false
    end
  end

  describe '#indentation_tabs' do
    it 'returns nil if there is no tabs as indentation' do
      line = "code code\n"
      expect(Linter.identation_tabs(line, 0).nil?).to be true
    end

    it 'returns a message if there is no an eol on file' do
      line = "\t\tcode code\n"
      expect(Linter.identation_tabs(line, 0).nil?).to be false
    end
  end

  describe '#spaces_before_terminator' do
    it 'returns nil if there is no spaces before line terminator' do
      line = "code code\n"
      actual = Linter.spaces_before_terminator(line, 0).nil?
      expect(actual).to be true
    end

    it 'returns a message if there are spaces before line terminator' do
      line = "code code \n"
      actual = Linter.spaces_before_terminator(line, 0).nil?
      expect(actual).to be false
    end
  end

  describe '#useless_semicolon' do
    it 'returns nil if there are no spaces before line terminator' do
      line = "code code\n"
      actual = Linter.useless_semicolon(line, 0).nil?
      expect(actual).to be true
    end

    it 'returns a message if there are spaces before line terminator' do
      line = "code code; \n"
      actual = Linter.useless_semicolon(line, 0).nil?
      expect(actual).to be false
    end
  end

  describe '#different_identation' do
    it 'returns nil if difference from previous indentation is standard' do
      diff_identation = 4
      actual = Linter.different_identation(0, diff_identation, 0).nil?
      expect(actual).to be true
    end

    it 'returns a message if diference from previous indentation is not standard' do
      diff_identation = 0
      actual = Linter.different_identation(0, diff_identation, 0).nil?
      expect(actual).to be false
    end
  end

  describe '#unspected_identation' do
    it 'always result a message' do
      actual = Linter.unspected_identation(0, 0).nil?
      expect(actual).to be false
    end
  end

  describe '#newline_symbol' do
    it 'always result a message' do
      actual = Linter.newline_symbol(0, 0).nil?
      expect(actual).to be false
    end
  end

  describe '#identation_rules' do
    it 'returns a message if the indentation is unexpected' do
      pre_line = "    code \n"
      act_line = "   code \n"
      actual = Linter.identation_rules(act_line, pre_line, 0)
      expect(actual[0]['unexpected'].nil?).to eq false
    end

    it 'returns a message if the block indentation is used for symbols' do
      pre_line = "  code() \n"
      act_line = "   code \n"
      actual = Linter.identation_rules(act_line, pre_line, 0)
      expect(actual[0]['unexpected'].nil?).to eq false
    end

    it 'returns a message if the block indentation not standard' do
      pre_line = "code():\n"
      act_line = "  code\n"
      actual = Linter.identation_rules(act_line, pre_line, 0)
      expect(actual[0]['identation'].nil?).to eq false
    end
  end
end
