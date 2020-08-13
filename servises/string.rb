class String
  def integer?
    Integer(self)

    true
  rescue ArgumentError, TypeError
    false
  end
end
