require "rails_helper"

RSpec.describe "Admin::Dashboard", type: :request do
  context "when user isn't logged in" do
    describe "GET /admin/" do
      it "redirects to the root_path with http status 302" do
        get "/admin/"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when user is logged in" do
    include_context :login_user

    describe "GET /admin/" do
      it "redirects to the root_path with http status 302" do
        get "/admin/"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when user is logged in with role :admin" do
    include_context :login_admin

    describe "GET /admin/" do
      it "render admin dashboard" do
        get "/admin/"
        expect(response).to have_http_status(:success)
        expect(response).to render_template("admin/dashboard/index")
      end
    end
  end
end
