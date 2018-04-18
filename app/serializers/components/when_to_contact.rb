module Serializers
  class WhenToContact < Base
    def initialize
    end

    def content
      {
        "template": "when-to-contact",
        "text": "You may be able to discuss issues with your MP in person or online. Contact them for details."
      }
    end
  end
end
