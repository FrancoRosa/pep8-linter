class String
  def identation_with_tabs
    self[/\A\t*/].size
  end
  def spaces_before_terminator
    self.chomp[/ *\z/].size
  end
  def identation
    self[/\A */].size
  end
  def end_colon?
    !self.chomp[/: *\z/].nil?
  end
  def end_semi_colon?
    !self.chomp[/; *\z/].nil?
  end
  def end_new_line_symbol?
    !self.chomp[/(\( *\z|, *\z|\+ *\z|\[ *\z)/].nil?
  end
end