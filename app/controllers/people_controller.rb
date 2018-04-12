class PeopleController < ApplicationController

  before_action :set_header, :data_check, :build_request, except: :postcode_lookup

  ROUTE_MAP = {
    index:   proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_index },
    show:    proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_by_id.set_url_params({ person_id: params[:person_id] }) },
    letters: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_by_initial.set_url_params({ initial: params[:letter] }) }
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
    ).produce_show_json
  end

  def index
    @people, @letters = Parliament::Utils::Helpers::FilterHelper.filter_sort(@request, :sort_name, 'Person', ::Grom::Node::BLANK)
    render json: Serializers::List.new(@people, Person, 'people').produce_json
  end

  def letters
    @people, @letters = Parliament::Utils::Helpers::FilterHelper.filter_sort(@request, :sort_name, 'Person', ::Grom::Node::BLANK)
    render json: Serializers::List.new(@people, Person, 'people').produce_json
  end

  private

  def set_header
    response.set_header("Content-Type", "application/x-shunter+json")
  end

end
