require_relative '../lib/features.rb'

RSpec.describe String do
  describe '#identation_with_tabs' do
    it 'counts the number of tabs before text, zero' do
      mystring = "\t\tthis is code\n"
      expect(mystring.identation_with_tabs).to eq 2
    end
    it 'counts the number of tabs before text' do
      mystring = "this is code\n"
      expect(mystring.identation_with_tabs).to eq 0
    end
  end
  describe '#spaces_before_terminator' do
    it 'counts the number of spaces before line terminator' do
      mystring = "this is code \n"
      expect(mystring.spaces_before_terminator).to eq 1
    end
    it 'counts the number of spaces before line terminator, zero' do
      mystring = "this is code\n"
      expect(mystring.spaces_before_terminator).to eq 0
    end
    it 'counts the number of spaces before line terminator, zero' do
      mystring = "this is code:\n"
      expect(mystring.spaces_before_terminator).to eq 0
    end
  end
  describe '#identation' do
    it 'counts the number of spaces preceding text' do
      mystring = "  this is code \n"
      expect(mystring.identation).to eq 2
    end
    it 'counts the number of spaces preceding text, zero' do
      mystring = "this is code \n"
      expect(mystring.identation).to eq 0
    end
  end
  describe '#end_colon?' do
    it 'returns true if there is a colon at the end of a line' do
      mystring = "this is code:"
      expect(mystring.end_colon?).to be true
    end
    it 'returns false if there is a colon at the end of a line' do
      mystring = "this is code \n"
      expect(mystring.end_colon?).to be false
    end
  end
  describe '#end_semi_colon?' do
    it 'returns true if there is a semi-colon at the end of a line' do
      mystring = "this is code ; "
      expect(mystring.end_semi_colon?).to be true
    end
    it 'returns false if there is a semi-colon at the end of a line' do
      mystring = "this is code \n"
      expect(mystring.end_semi_colon?).to be false
    end
  end
  describe '#end_new_line_symbol?' do
    it 'returns true if there is "," at the end of a line' do
      mystring = "this is code , \n"
      expect(mystring.end_new_line_symbol?).to be true
    end
    it 'returns true if there is a "(" at the end of a line' do
      mystring = "this is code ( \n"
      expect(mystring.end_new_line_symbol?).to be true
    end
    it 'returns false if there is not "(" or "," or "+" at the end of a line' do
      mystring = "this is code \n"
      expect(mystring.end_new_line_symbol?).to be false
    end
  end
end
