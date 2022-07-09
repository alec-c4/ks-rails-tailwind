class Customer::BaseController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  # Pundit policy override
  def policy_scope(scope)
    super([:customer, scope])
  end

  def authorize(record, query = nil)
    super([:customer, record], query)
  end  
end
