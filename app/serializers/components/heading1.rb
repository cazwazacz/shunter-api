module Serializers
  class Heading1 < Base
    def initialize(person)
      @person = person
    end

    def content
      {
          name: "heading1",
          data: "#{@person.full_name}"
      }
    end
  end
end