class PagesController < ApplicationController
  def home
    ahoy.track "Open home page"
  end

  def terms
    ahoy.track "Open terms page"
  end

  def privacy
    ahoy.track "Open privacy page"
  end

  def about
    ahoy.track "Open about page"
  end
end
