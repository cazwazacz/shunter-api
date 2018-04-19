class BaseSerializer
  def to_h
    content
  end

  private

  def content
    raise StandardError, "You must implement #content."
  end
end