module PageSerializer
  class ListPageSerializer < PageSerializer::BasePageSerializer
    def initialize(objects, klass, object_name, letters, active_letter = 'all')
      @objects = objects
      @klass = klass
      @object_name = object_name
      @letters = letters
      @active_letter = active_letter
    end

    private

    def title
      if @active_letter != 'all'
        "#{@object_name.capitalize} A to Z showing results for #{@active_letter.capitalize} - UK Parliament"
      else
        'People - UK Parliament' if @active_letter == 'all'
      end
    end

    def content
      [
          ComponentSerializer::LetterNavigationComponentSerializer.new(@letters, @active_letter, @object_name).to_h,
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