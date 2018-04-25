class ConstituenciesController < ApplicationController

  def show
    render_page { layout: { template: "layout" } }
  end

end