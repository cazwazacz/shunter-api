class PeopleController < ApplicationController

  before_action :set_header, :data_check, :build_request, except: :postcode_lookup

  ROUTE_MAP = {
    show:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_by_id.set_url_params({ person_id: params[:person_id] }) },
    lookup: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_lookup.set_url_params({ property: params[:source], value: params[:id] }) }
  }.freeze

  def show
    @person, @seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Person', 'SeatIncumbency', 'FormalBodyMembership', 'GovernmentIncumbency', 'OppositionIncumbency')
    @person = @person.first

    @subheading = "Former MP" if @person.former_mp?
    @subheading = "Former Member of the House of Lords" if @person.former_lord?
    @subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} MP for #{@person.current_seat_incumbency.constituency.name}" if @person.current_mp?
    @subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} - #{@person.statuses[:house_membership_status].join(' and ')}" if @person.current_lord?

    @when_to_contact = { "template": "when-to-contact", "text": "You may be able to discuss issues with your MP in person or online. Contact them for details." } if @person.current_mp?

    @contact_points = []
    @person.try(&:current_seat_incumbency).try(&:contact_points).each do |contact_point|
      @contact_points << {
        "email": contact_point.email,
        "phone": contact_point.phone_number,
        "addresses": contact_point.postal_addresses.map(&:full_address)
      }
    end

    # Only seat incumbencies, not committee roles are being grouped
    incumbencies = GroupingHelper.group(@seat_incumbencies, :constituency, :graph_id)

    roles = []
    roles += incumbencies
    roles += @committee_memberships.to_a if Pugin::Feature::Bandiera.show_committees?
    roles += @government_incumbencies.to_a if Pugin::Feature::Bandiera.show_government_roles?
    roles += @opposition_incumbencies.to_a if Pugin::Feature::Bandiera.show_opposition_roles?

    HistoryHelper.reset
    HistoryHelper.add(roles)
    @history = HistoryHelper.history

    @current_roles = RoleHelper.organise_roles(@history[:current]) if @history[:current]
    @timeline_roles = RoleHelper.build_timeline(@history, @current_roles)

    person_hash = {
      "layout": {
        "template": "layout",
        "page_template": "people__show"
      },
      "title": "#{@person.display_name} UK Parliament",
      "components": {
        "cookie-banner": "cookie-banner",
        "top-navigation": "top-navigation",
        "header": "header",
        "heading1": "#{@person.full_name}",
        "subheading": @subheading,
        "image": {
          "template": "person-image",
          "figure-url": "/media/#{@person.graph_id}",
          "image-srcset1": "#{ENV['IMAGE_SERVICE_URL']}/#{@person.image_id}.jpeg?crop=CU_5:2&width=732&quality=80, #{ENV['IMAGE_SERVICE_URL']}/#{@person.image_id}.jpeg?crop=CU_5:2&width=1464&quality=80 2x",
          "image-srcset2": "#{ENV['IMAGE_SERVICE_URL']}/#{@person.image_id}.jpeg?crop=MCU_3:2&width=444&quality=80, #{ENV['IMAGE_SERVICE_URL']}/#{@person.image_id}.jpeg?crop=MCU_3:2&width=888&quality=80 2x",
          "image-src": "#{ENV['IMAGE_SERVICE_URL']}/#{@person.image_id}.jpeg?crop=CU_1:1&width=186&quality=80",
          "image-alt": "#{@person.display_name}"
        },
        "when-to-contact": @when_to_contact,
        "contact": {
          "template": "contact",
          "contact-points": @contact_points
        },
        "roles": {
          "template": "roles",
          "role-list": @current_roles
        },
        "timeline": {
          "template": "timeline",
          "timeline-roles": @timeline_roles
        },
        "related-links": {
          "template": "related-links",
          "name": @person.full_name,
          "website": @person.personal_weblinks,
          "twitter": @person.twitter_weblinks,
          "media-url": "/media/#{@person.image_id}"
        },
        "footer": "footer"
      }
    }

    render json: SerializerHelper.add_components(person_hash, options = { "cookie-banner": false })
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
