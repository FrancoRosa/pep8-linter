class String
  def indentation_with_tabs
    self[/\A\t*/].size
  end

  def spaces_before_terminator
    chomp[/ *\z/].size
  end

  def indentation
    self[/\A */].size
  end

  def end_colon?
    !chomp[/: *\z/].nil?
  end

  def end_semi_colon?
    !chomp[/; *\z/].nil?
  end

  def end_new_line_symbol?
    !chomp[/(\( *\z|, *\z|\+ *\z|\[ *\z)/].nil?
  end
end
