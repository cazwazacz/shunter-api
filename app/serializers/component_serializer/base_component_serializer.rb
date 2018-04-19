module ComponentSerializer
  class BaseComponentSerializer < BaseSerializer

    def content
      {
          name: name,
          data: data
      }
    end

    def name
      raise StandardError, "Please specify name"
    end

    def data
      raise StandardError, "Please specify data"
    end
  end
end