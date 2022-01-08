class Customer::DashboardController < Customer::BaseController
  def index
    ahoy.track("Open customer dashboard")
    authorize %i[customer dashboard], :index?
  end
end
