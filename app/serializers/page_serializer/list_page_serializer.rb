module PageSerializer
  class ListPageSerializer < PageSerializer::BasePageSerializer
    def initialize(objects, klass, objects_name, letters, active_letter)
      @objects = objects
      @klass = klass
      @object_name = objects_name
      @letters = letters
      @active_letter = active_letter
    end

    private

    def title
      "#{@object_name.capitalize} A to Z showing results for #{@active_letter.capitalize} - UK Parliament"
    end

    def content
      [
          ComponentSerializer::LetterNavigationComponentSerializer.new(@letters, @active_letter).to_h,
          { name: @object_name, data: list }
      ]
    end

    def list
      @objects.map do |object|
        @klass.new(object).to_h
      end
    end
  end
end