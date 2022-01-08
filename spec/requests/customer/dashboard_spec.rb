require "rails_helper"

RSpec.describe "Customer::Dashboard", type: :request do
  context "when user isn't logged in" do
    describe "GET /" do
      it "render landing" do
        get "/"
        expect(response).to have_http_status(:success)
        expect(response).to render_template("pages/home")
      end
    end
  end

  context "when user is logged in" do
    include_context :login_user

    describe "GET /" do
      it "render dashboard" do
        get "/"
        expect(response).to have_http_status(:success)
        expect(response).to render_template("customer/dashboard/index")
      end
    end
  end
end
