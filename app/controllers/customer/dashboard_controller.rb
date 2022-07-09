class Customer::DashboardController < Customer::BaseController
  def index
    ahoy.track "Open customer dashboard"
    authorize :dashboard, :index?
  end
end
