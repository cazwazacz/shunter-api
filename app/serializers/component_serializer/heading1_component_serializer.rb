module ComponentSerializer
  class Heading1ComponentSerializer < BaseComponentSerializer
    def initialize(person)
      @person = person
    end

    def name
      "heading 1"
    end

    def data
      "#{@person.full_name}"
    end
  end
end