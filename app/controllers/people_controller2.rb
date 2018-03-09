class PeopleController < ApplicationController
  before_action :set_header

  def show
    render json: {
      "layout": {
        "template": "layout",
        "page_template": "people__show"
      },
      "title": "Ms Diane Abbott - UK Parliament",
      "components": {
        "cookie-banner": "cookie-banner",
        "banner": "banner",
        "header": "header",
        "top-navigation": "top-navigation",
        "heading1": "Diane Abbott",
        "subheading": "Labour MP for Hackney North and Stoke Newington",
        "image": {
          "template": "person-image",
          "media-uri": "/media/S3bGSTqn",
          "image-src": "https://api.parliament.uk/Live/photo/S3bGSTqn.jpeg?crop=CU_5:2&width=1464&quality=80",
          "image-alt": "Ms Diane Abbott"
        },
        "contact": {
          "template": "contact",
          "email": "diane.abbott.office@parliament.uk",
          "phone": "020 7219 4426",
          "address": "House of Commons, London, SW1A 0AA"
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
          "website": "http://www.dianeabbott.org.uk/",
          "twitter": "https://twitter.com/HackneyAbbott",
          "media-url": "/media/S3bGSTqn",
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
