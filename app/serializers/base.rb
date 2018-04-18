module Serializers
  class Base
    def to_h
      content
    end

    def content
      {}
    end
  end
end
