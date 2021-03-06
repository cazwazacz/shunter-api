require_relative '../rails_helper'

RSpec.describe ConstituenciesController, vcr: true do
  describe 'GET show' do
    before(:each) do
      allow(PageSerializer::ConstituencyShowPageSerializer).to receive(:new)
      get :show, params: { constituency_id: 'yyocmekJ' }
    end

    it 'should have a response with status 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @constituency, @seat_incumbencies, @current_incumbency, @json_location and @current_party_member' do
      expect(assigns(:constituency)).to be_a(Grom::Node)
      expect(assigns(:constituency).type).to eq('https://id.parliament.uk/schema/ConstituencyGroup')

      assigns(:seat_incumbencies).each do |seat_incumbency|
        expect(seat_incumbency).to be_a(Grom::Node)
        expect(seat_incumbency.type).to eq('https://id.parliament.uk/schema/SeatIncumbency')
      end

      expect(assigns(:current_incumbency)).to be_a(Grom::Node)
      expect(assigns(:current_incumbency).type).to eq('https://id.parliament.uk/schema/SeatIncumbency')

      expect(assigns(:json_location)).to eq('/constituencies/yyocmekJ/map.json')

      expect(assigns(:current_party_member)).to be_a(Grom::Node)
      expect(assigns(:current_party_member).type).to eq('https://id.parliament.uk/schema/Person')
    end

    it 'calls the ConstituencyShowPageSerializer with the correct arguments' do
      expect(PageSerializer::ConstituencyShowPageSerializer).to have_received(:new).with(
        assigns(:constituency),
        assigns(:json_location),
        assigns(:current_party_member),
        assigns(:seat_incumbencies)
      )
    end
  end

  describe 'GET index' do
    before(:each) do
      allow(PageSerializer::ListPageSerializer).to receive(:new)
      get :index
    end

    it 'should have a response with status 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @constituencies and @letters' do
      assigns(:constituencies).each do |constituency|
        expect(constituency).to be_a(Grom::Node)
        expect(constituency.type).to eq('https://id.parliament.uk/schema/ConstituencyGroup')
      end

      assigns(:letters).each do |letter|
        expect(letter).to be_a(String)
      end
    end

    it 'calls the ListPageSerializer with the correct arguments' do
      expect(PageSerializer::ListPageSerializer).to have_received(:new).with(
          assigns[:constituencies],
          ComponentSerializer::ConstituencyComponentSerializer,
          'constituencies',
          assigns[:letters]
      )
    end
  end

  describe 'GET letters' do
    before(:each) do
      allow(PageSerializer::ListPageSerializer).to receive(:new)
      get :letters, params: { letter: 'a' }
    end

    it 'should have a response with status 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @constituencies and @letters' do
      assigns(:constituencies).each do |constituency|
        expect(constituency).to be_a(Grom::Node)
        expect(constituency.type).to eq('https://id.parliament.uk/schema/ConstituencyGroup')
      end

      assigns(:letters).each do |letter|
        expect(letter).to be_a(String)
      end
    end

    it 'calls the ListPageSerializer with the correct arguments' do
      expect(PageSerializer::ListPageSerializer).to have_received(:new).with(
        assigns[:constituencies],
        ComponentSerializer::ConstituencyComponentSerializer,
        'constituencies',
        assigns[:letters],
        'a'
      )
    end
  end
end