class PeopleController < ApplicationController

  before_action :set_header, :data_check, :build_request, except: :postcode_lookup

  ROUTE_MAP = {
    show:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_by_id.set_url_params({ person_id: params[:person_id] }) },
    lookup: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_lookup.set_url_params({ property: params[:source], value: params[:id] }) }
  }.freeze

  def show
    @person, @seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Person', 'SeatIncumbency', 'FormalBodyMembership', 'GovernmentIncumbency', 'OppositionIncumbency')
    @person = @person.first

    render json: Serializers::Person.new(
      @person,
      @seat_incumbencies,
      @committee_memberships,
      @government_incumbencies,
      @opposition_incumbencies,
      options = { "top-navigation": false }
    ).produce_json
  end

  def index
    render :json => {
      "layout": {
        "template": "people__index"
      },
      "people": [
        {
          "display_name": "Diane Abbott",
          "graph_id": "43RHonMf",
          "role": "MP for Hackney North and Stoke Newington",
          "current_party": "Labour",
        },
        {
          "display_name": "Lord Aberconway",
          "graph_id": "O0giLg8A",
          "role": "MP for Hackney North and Stoke Newington",
          "current_party": "Labour",
        }
      ]
    }
  end

  private

  def set_header
    response.set_header("Content-Type", "application/x-shunter+json")
  end

end
