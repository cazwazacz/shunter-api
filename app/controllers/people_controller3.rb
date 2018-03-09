class PeopleController < ApplicationController
  include ActiveModel::Serializers::JSON

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
    @subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} #{@person.statuses[:house_membership_status].join(' and ')}" if @person.current_lord?

    @when_to_contact = { "template": "when-to-contact", "text": "You may be able to discuss issues with your MP in person or online. Contact them for details." } if @person.current_mp?

    @contact_points = []
    @person.current_seat_incumbency.contact_points.each do |contact_point|
      @contact_points << {
        "email": contact_point.email,
        "phone": contact_point.phone_number,
        "addresses": contact_point.postal_addresses.map(&:full_address)
      }
    end

    render json: {
      "layout": {
        "template": "layout",
        "page_template": "people__show"
      },
      "title": "#{@person.display_name} - UK Parliament",
      "components": {
        "cookie-banner": "cookie-banner",
        "banner": "banner",
        "header": "header",
        "top-navigation": "top-navigation",
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
          "role-list": [
            {
              "role-type": "Opposition role",
              "role-title": "Shadow Home Secretary",
              "role-dates": [
                "6 Oct 2016 to present"
              ]
            },
            {
              "role-type": "Parliamentary role",
              "role-title": "MP for Hackney North and Stoke Newington",
              "role-count": "Elected 3 times",
              "role-dates": [
                "8 Jun 2017 to present",
                "7 May 2015 to 3 May 2017",
                "6 May 2010 to 30 Mar 2015"
              ]
            }
          ]
        },
        "timeline": {
          "template": "timeline",
          "timeline-roles": [
            {
              "time-period": "Held currently",
              "roles": [
                {
                  "role-title": "MP for Hackney North and Stoke Newington",
                  "role-count": "Elected 3 times",
                  "role-dates": [
                    "8 Jun 2017 to present",
                    "7 May 2015 to 3 May 2017",
                    "6 May 2010 to 30 Mar 2015"
                  ]
                },
                {
                  "role-type": "Opposition role",
                  "role-title": "Shadow Home Secretary",
                  "role-dates": [
                    "6 Oct 2016 to present"
                  ]
                }
              ],
            },
            {
              "time-period": "Held in the last 10 years",
              "roles": [
                {
                  "role-title": "Shadow Secretary of State for Health",
                  "role-type": "Opposition role",
                  "role-dates": [
                    "27 Jun 2016 to 6 Oct 2016"
                  ]
                },
                {
                  "role-title": "Shadow Secretary of State for International Development",
                  "role-type": "Opposition role",
                  "role-dates": [
                    "14 Sep 2015 to 27 Jun 2016"
                  ]
                }
              ]
            },
            {
              "time-period": "Held in the last 20 years",
              "roles": [
                {
                  "role-title": "Member of the Foreign Affairs Committee",
                  "role-type": "Committee role",
                  "role-dates": [
                    "16 Jul 1997 to 11 May 2001"
                  ]
                },
              ]
            },
            {
              "time-period": "1987"
            }
          ]
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
