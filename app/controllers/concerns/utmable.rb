module Utmable
  extend ActiveSupport::Concern

  def utm_resource(resource)
    [:utm_source, :utm_campaign, :utm_medium, :utm_term, :utm_content, :gclid].each do |utm|
      resource.send("#{utm}=", cookies[utm].presence)
    end
  end

  def utm_clear_cookies
    [:utm_source, :utm_campaign, :utm_medium, :utm_term, :utm_content, :gclid].each do |utm|
      cookies.delete utm
    end
  end
end
