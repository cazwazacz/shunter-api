class BaseSerializer
  def to_h
    content
  end

  private

  def content
    raise StandardError, "Please use a serializer"
  end
end