class CheckRule
  def self.line_terminator(file_data)
    if file_data[-1][-1] == "\n"
      false
    else
      rule ='rule: there should be a line terminator on last line' 
      location = "line: #{file_data.size} col: #{file_data[-1].size}" 
      return true, rule, location
    end
  end

  def self.identation(file_data)
    puts "######################"
    puts "###### Identation Rule #####"
    puts "######################"
    file_data.each do |line|
      print line + '  '
      print line[/\A */].size.to_s  + '  '
      puts line[/ *\z/].size.to_s
    end
  end
end