require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::WhenToContactComponentSerializer do
  context '#to_h' do
    it 'returns a hash with the name and when to contact data' do
      data =       {
          'template':'when-to-contact',
          'text': 'You may be able to discuss issues with your MP in person or online. Contact them for details.'
      }
      hash = { name: 'when-to-contact', data: data }
      expect(subject.to_h).to eq hash
    end
  end
end