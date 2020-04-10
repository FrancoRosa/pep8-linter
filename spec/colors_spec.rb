require_relative '../lib/colors.rb'

RSpec.describe String do
  let(:mystring) { 'HelloWorld!' }
  describe '#red' do
    it 'changes the way a string is shown on therminal' do
      expect(mystring.red).to eq "\e[31m#{mystring}\e[0m"
    end
  end
  describe '#green' do
    it 'changes the way a string is shown on therminal' do
      expect(mystring.green).to eq "\e[32m#{mystring}\e[0m"
    end
  end
  describe '#bold' do
    it 'changes the way a string is shown on therminal' do
      expect(mystring.bold).to eq "\e[1m#{mystring}\e[22m"
    end
  end
  describe '#gray' do
    it 'changes the way a string is shown on therminal' do
      expect(mystring.gray).to eq "\e[37m#{mystring}\e[0m"
    end
  end
  describe '#reverse' do
    it 'changes the way a string is shown on therminal' do
      expect(mystring.reverse_color).to eq "\e[7m#{mystring}\e[27m"
    end
  end
end
