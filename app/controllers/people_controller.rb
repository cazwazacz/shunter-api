class PeopleController < ApplicationController

  def show
    response.set_header("Content-Type", "application/x-shunter+json")
    render :json => {
      "layout": {
        "template": "people__show"
      },
      "display_name": "Diane Abbott",
      "current_party": "Labour",
      "constituency": {
        "name": "Hackney North and Stoke Newington",
        "graph_id": "5bX5Se0u"
      },
      "image": "https://api.parliament.uk/Live/photo/S3bGSTqn.jpeg?crop=CU_5:2&width=1464&quality=80"
    }
  end
end
