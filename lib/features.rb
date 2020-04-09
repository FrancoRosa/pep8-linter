class String
  def identation_with_tabs
    self[/\A\t*/].size
  end
  def spaces_before_terminator
    self[/ *\z/].chomp.size
  end
  def identation
    self[/\A */].size
  end
  def end_colon?
    self[/: *\z/].size.zero?
  end
  def end_semi_colon?
    self[/; *\z/].size.zero?
  end
end