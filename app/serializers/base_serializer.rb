class BaseSerializer
  def to_h
    content
  end

  def content
    raise StandardError, "Please use a serializer"
  end
end