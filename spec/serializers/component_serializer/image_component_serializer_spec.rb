require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::ImageComponentSerializer do
  let(:object) { double('object', graph_id: '321', display_name: 'Diane Abbott', image_id: 123) }

  let (:serializer) { described_class.new(object) }

  context '#to_h' do
    it 'returns a hash with the name and image data' do
      data = {
          template: 'person-image',
          'figure-url': '/media/321',
          'image-srcset1': 'https://api.parliament.uk/Staging/photo/123.jpeg?crop=CU_5:2&width=732&quality=80, https://api.parliament.uk/Staging/photo/123.jpeg?crop=CU_5:2&width=1464&quality=80 2x',
          'image-srcset2': 'https://api.parliament.uk/Staging/photo/123.jpeg?crop=MCU_3:2&width=444&quality=80, https://api.parliament.uk/Staging/photo/123.jpeg?crop=MCU_3:2&width=888&quality=80 2x',
          'image-src': 'https://api.parliament.uk/Staging/photo/123.jpeg?crop=CU_1:1&width=186&quality=80',
          'image-alt': 'Diane Abbott'
      }
      hash = { name: 'image', data: data }
      expect(serializer.to_h).to eq hash
    end
  end
end