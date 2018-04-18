module Serializers
  class Image < Base
    def initialize(object)
      @object = object
    end

    def content
      {
        "template": "person-image",
        "figure-url": "/media/#{@object.graph_id}",
        "image-srcset1": "#{ENV['IMAGE_SERVICE_URL']}/#{@object.image_id}.jpeg?crop=CU_5:2&width=732&quality=80, #{ENV['IMAGE_SERVICE_URL']}/#{@object.image_id}.jpeg?crop=CU_5:2&width=1464&quality=80 2x",
        "image-srcset2": "#{ENV['IMAGE_SERVICE_URL']}/#{@object.image_id}.jpeg?crop=MCU_3:2&width=444&quality=80, #{ENV['IMAGE_SERVICE_URL']}/#{@object.image_id}.jpeg?crop=MCU_3:2&width=888&quality=80 2x",
        "image-src": "#{ENV['IMAGE_SERVICE_URL']}/#{@object.image_id}.jpeg?crop=CU_1:1&width=186&quality=80",
        "image-alt": "#{@object.display_name}"
      }
    end
  end
end
