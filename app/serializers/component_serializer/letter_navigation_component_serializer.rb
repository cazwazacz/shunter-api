module ComponentSerializer
  class LetterNavigationComponentSerializer < BaseComponentSerializer
    def initialize(letters, active_letter, object_name)
      @letters = letters
      @active_letter = active_letter
      @object_name = object_name
    end

    private

    def name
      "letter-navigation"
    end

    def data
      {
          'object_name': @object_name,
          letters: letter_navigation_data
      }
    end

    def letter_navigation_data
      ("A".."Z").map do |letter|
        presence = @letters.include?(letter) ? true : nil
        { letter: letter, presence: presence, active: active?(letter) }
      end
    end

    def active?(letter)
      letter == @active_letter.upcase ? true : nil
    end
  end
end