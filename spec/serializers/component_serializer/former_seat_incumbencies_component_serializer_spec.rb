require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::FormerSeatIncumbenciesComponentSerializer do

  let(:member1) { double('member1', display_name: 'Stephen Kinnock', graph_id: '123') }
  let(:member2) { double('member2', display_name: 'Guto Bebb', graph_id: '456') }
  let(:member3) { double('member3', display_name: 'Diane Abbott', graph_id: '789') }
  let(:seat_incumbency1) { double('seat_incumbency1', member: member1, current?: true, date_range: '4 May 2010 to 4 June 2010') }
  let(:seat_incumbency2) { double('seat_incumbency2', member: member2, current?: false, date_range: '3 May 2002 to 5 June 2004') }
  let(:seat_incumbency3) { double('seat_incumbency3', member: member3, current?: false, date_range: '2 May 2005 to 5 June 2007') }
  let(:seat_incumbencies) { [seat_incumbency1, seat_incumbency2, seat_incumbency3] }
  let(:serializer) { described_class.new(seat_incumbencies) }

  context '#to_h' do
    it 'creates a hash with an array of former seat incumbencies' do
      hash = {
          name: 'former-seat-incumbencies',
          data: [
              {
                  member_name: 'Guto Bebb',
                  graph_id: '456',
                  date_range: '3 May 2002 to 5 June 2004'
              },
              {
                  member_name: 'Diane Abbott',
                  graph_id: '789',
                  date_range: '2 May 2005 to 5 June 2007'
              }
          ]
      }
      expect(serializer.to_h).to eq hash
    end
  end

end