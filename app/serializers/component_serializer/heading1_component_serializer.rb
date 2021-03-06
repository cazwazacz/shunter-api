module ComponentSerializer
  class Heading1ComponentSerializer < BaseComponentSerializer
    def initialize(person)
      @person = person
    end

    private

    def name
      "heading1"
    end

    def data
      "#{@person.full_name}"
    end
  end
end