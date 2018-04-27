require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::LetterNavigationComponentSerializer do

  let (:active_letter) { 'C' }
  let (:letters) { %{A C} }
  let (:serializer) { described_class.new(letters, active_letter, 'object_name') }

  context '#to_h' do
    it 'returns the navigation data' do
      data = [
          { letter: 'A', presence: true, active: nil },
          { letter: 'B', presence: nil, active: nil },
          { letter: 'C', presence: true, active: true },
          { letter: 'D', presence: nil, active: nil },
          { letter: 'E', presence: nil, active: nil },
          { letter: 'F', presence: nil, active: nil },
          { letter: 'G', presence: nil, active: nil },
          { letter: 'H', presence: nil, active: nil },
          { letter: 'I', presence: nil, active: nil },
          { letter: 'J', presence: nil, active: nil },
          { letter: 'K', presence: nil, active: nil },
          { letter: 'L', presence: nil, active: nil },
          { letter: 'M', presence: nil, active: nil },
          { letter: 'N', presence: nil, active: nil },
          { letter: 'O', presence: nil, active: nil },
          { letter: 'P', presence: nil, active: nil },
          { letter: 'Q', presence: nil, active: nil },
          { letter: 'R', presence: nil, active: nil },
          { letter: 'S', presence: nil, active: nil },
          { letter: 'T', presence: nil, active: nil },
          { letter: 'U', presence: nil, active: nil },
          { letter: 'V', presence: nil, active: nil },
          { letter: 'W', presence: nil, active: nil },
          { letter: 'X', presence: nil, active: nil },
          { letter: 'Y', presence: nil, active: nil },
          { letter: 'Z', presence: nil, active: nil }
      ]
      hash = { name: 'letter-navigation', data: { object_name: 'object_name', letters: data } }
      expect(serializer.to_h).to eq hash
    end
  end
end