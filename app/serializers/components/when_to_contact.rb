module Serializers
  class WhenToContact < Base
    def initialize
    end

    def name
      "when-to-contact"
    end

    def data
      when_to_contact_data
    end

    def when_to_contact_data
      {
          "template": "when-to-contact",
          "text": "You may be able to discuss issues with your MP in person or online. Contact them for details."
      }
    end
  end
end
