require_relative '../rails_helper'

RSpec.describe PeopleController, vcr: true do
  describe 'GET show' do
    before(:each) do
      allow(PageSerializer::PersonShowPageSerializer).to receive(:new)
      get :show, params: { person_id: '43RHonMf' }
    end

    it 'should have a response with status 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @person, @seat_incumbencies, @committee_memberships, @government_incumbencies, @current_party_membership,
    @most_recent_incumbency and @current_incumbency' do
      expect(assigns(:person)).to be_a(Grom::Node)
      expect(assigns(:person).type).to eq('https://id.parliament.uk/schema/Person')

      assigns(:seat_incumbencies).each do |seat_incumbency|
        expect(seat_incumbency).to be_a(Grom::Node)
        expect(seat_incumbency.type).to eq('https://id.parliament.uk/schema/SeatIncumbency')
      end

      assigns(:committee_memberships).each do |committee_membership|
        expect(committee_membership).to be_a(Grom::Node)
        expect(committee_membership.type).to eq('https://id.parliament.uk/schema/FormalBodyMembership')
      end

      assigns(:government_incumbencies).each do |government_incumbency|
        expect(government_incumbency).to be_a(Grom::Node)
        expect(government_incumbency.type).to eq('https://id.parliament.uk/schema/GovernmentIncumbency')
      end

      assigns(:opposition_incumbencies).each do |opposition_incumbency|
        expect(opposition_incumbency).to be_a(Grom::Node)
        expect(opposition_incumbency.type).to eq('https://id.parliament.uk/schema/OppositionIncumbency')
      end
    end

    it 'calls the PersonShowPageSerializer with the correct arguments' do
      expect(PageSerializer::PersonShowPageSerializer).to have_received(:new).with(
          assigns(:person),
          assigns(:seat_incumbencies),
          assigns(:committee_memberships),
          assigns(:government_incumbencies),
          assigns(:opposition_incumbencies)
      )
    end

  end
end