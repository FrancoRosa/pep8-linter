require_relative '../lib/check_rule.rb'

RSpec.describe CheckRule do
  describe '#line_terminator' do
    it 'returns nil if there is an eol on file' do
      file_data = [["code code \n"],
                   ["code code\n"]]
      expect(CheckRule.line_terminator(file_data).nil?).to be false
    end

    it 'returns a mesage if there is no an eol on file' do
      file_data = [["code code \n"],
                   ['code code']]
      expect(CheckRule.line_terminator(file_data).nil?).to be false
    end
  end

  describe '#identation_tabs' do
    it 'returns nil if there is no tabs as identation' do
      line = "code code\n"
      expect(CheckRule.identation_tabs(line, 0).nil?).to be true
    end

    it 'returns a mesage if there is no an eol on file' do
      line = "\t\tcode code\n"
      expect(CheckRule.identation_tabs(line, 0).nil?).to be false
    end
  end

  describe '#spaces_before_terminator' do
    it 'returns nil if there is no spaces before line terminator' do
      line = "code code\n"
      actual = CheckRule.spaces_before_terminator(line, 0).nil?
      expect(actual).to be true
    end

    it 'returns a message if there is espaces before line terminator' do
      line = "code code \n"
      actual = CheckRule.spaces_before_terminator(line, 0).nil?
      expect(actual).to be false
    end
  end

  describe '#useless_semicolon' do
    it 'returns nil if there is no spaces before line terminator' do
      line = "code code\n"
      actual = CheckRule.useless_semicolon(line, 0).nil?
      expect(actual).to be true
    end

    it 'returns a message if there is espaces before line terminator' do
      line = "code code; \n"
      actual = CheckRule.useless_semicolon(line, 0).nil?
      expect(actual).to be false
    end
  end

  describe '#different_identation' do
    it 'returns nil if difference from previous identation is standard' do
      diff_identation = 4
      actual = CheckRule.different_identation(0, diff_identation, 0).nil?
      expect(actual).to be true
    end

    it 'returns a message if diference from previous identation is not standard' do
      diff_identation = 0
      actual = CheckRule.different_identation(0, diff_identation, 0).nil?
      expect(actual).to be false
    end
  end

  describe '#unspected_identation' do
    it 'always result a message' do
      actual = CheckRule.unspected_identation(0, 0).nil?
      expect(actual).to be false
    end
  end

  describe '#newline_symbol' do
    it 'always result a message' do
      actual = CheckRule.newline_symbol(0, 0).nil?
      expect(actual).to be false
    end
  end

  describe '#identation_rules' do
    it 'returns a message if the identation is unexpected' do
      pre_line = "    code \n"
      act_line = "   code \n"
      actual = CheckRule.identation_rules(act_line, pre_line, 0)
      expect(actual[0]['unexpected'].nil?).to eq false
    end

    it 'returns a message if the block identation is used for symbols' do
      pre_line = "  code() \n"
      act_line = "   code \n"
      actual = CheckRule.identation_rules(act_line, pre_line, 0)
      expect(actual[0]['unexpected'].nil?).to eq false
    end

    it 'returns a message if the block identation not standard' do
      pre_line = "code():\n"
      act_line = "  code\n"
      actual = CheckRule.identation_rules(act_line, pre_line, 0)
      expect(actual[0]['identation'].nil?).to eq false
    end
  end
end
