class String
  def green
    "\e[32m#{self}\e[0m"
  end

  def bold
    "\e[1m#{self}\e[22m"
  end

  def reverse_color
    "\e[7m#{self}\e[27m"
  end

  def gray
    "\e[37m#{self}\e[0m"
  end
end
