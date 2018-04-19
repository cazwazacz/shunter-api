module Serializers
  class Component < Base
    def initialize(name, data)
      @name = name
      @data = data
    end

    def content
      name_and_data_hash(@name, @data)
    end

    def name_and_data_hash(name, data)
      {
          name: name,
          data: data
      }
    end

  end
end