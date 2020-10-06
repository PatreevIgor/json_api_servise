class String
  def number?
    Integer(self)

    true
  rescue ArgumentError, TypeError
    false
  end
end
