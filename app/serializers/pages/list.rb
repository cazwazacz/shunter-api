module Serializers
  class List
    # Instance of a list, that is generated using a list of provided objects
    #
    # @param objects [Array] Array of Grom::Nodes to be listed
    # @param klass [Class] Corresponding Serializers class that objects need to be an instance of
    # @param objects_name [String] How list of objects will be referred to in outgoing JSON
    # @param options [Hash] Hash of optional parameters, indicating whether or not feature should be included in outgoing JSON
    # @return [Object] Serializers::List object
    #
    def initialize(objects, klass, objects_name, letters, active_letter, options = {})
      @objects = objects
      @klass = klass
      @objects_name = objects_name
      @options = options
      @letters = letters
      @active_letter = active_letter
    end

    def produce_json
      base_json_hash = Serializers::Base.new(@options).produce_json
      base_and_objects_json_hash = produce_objects_json(base_json_hash)
      base_and_objects_json_hash.to_json
    end

    private

    def produce_objects_json(json_hash)
      json_hash.tap do |hash|
        hash["layout"] = {}
        hash["layout"]["template"] = "layout"
        hash["layout"]["page_template"] = "#{@objects_name}__index"
        # hash["#{@objects_name}"] = organise_objects
        hash["components"] << { name: "people",  data: organise_objects }
        hash["components"] << { name: "letter-navigation", data: produce_letters_array}
      end
    end

    def produce_letters_array
      letters_array = []
      all_letters_array = ("A".."Z").to_a
      all_letters_array.each do |letter|
        if @letters.include?(letter)
          letters_array << { letter: letter, presence: true, active: indicate_active_letter(letter)}
        else
          letters_array << { letter: letter, presence: nil, active: indicate_active_letter(letter)}
        end
      end
      letters_array
    end

    def indicate_active_letter(letter)
     letter == @active_letter.upcase ? true : nil
    end

    def organise_objects
      objects_to_json = []
      @objects.each do |object|
        objects_to_json << @klass.new(object).produce_list_json
      end
      objects_to_json
    end
  end
end
