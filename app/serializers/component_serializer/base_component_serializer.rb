module ComponentSerializer
  class BaseComponentSerializer < BaseSerializer

    private

    def content
      {
          name: name,
          data: data
      }
    end

    def name
      raise StandardError, "You must implement #name."
    end

    def data
      raise StandardError, "You must implement #data."
    end
  end
end