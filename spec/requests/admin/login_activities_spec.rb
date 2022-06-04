require "rails_helper"

RSpec.describe "Admin::LoginActivities", type: :request do
  let(:user) { create(:user) }

  context "when user isn't logged in" do
    describe "GET /admin/users/:user_id/login_activities" do
      it "redirects to the root_path with http status 302" do
        get admin_user_login_activities_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET /admin/login_activities/:id" do
      it "redirects to the root_path with http status 302" do
        get admin_user_login_activities_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when user is logged in" do
    include_context :login_user

    describe "GET /admin/users/:user_id/login_activities" do
      it "redirects to the root_path with http status 302" do
        get admin_user_login_activities_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET /admin/login_activities/:id" do
      it "redirects to the root_path with http status 302" do
        get "/admin/users/#{user.id}/login_activities"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when user is logged in with role :admin" do
    include_context :login_admin

    describe "GET /admin/users/:user_id/login_activities" do
      it "renders admin login activities page" do
        get "/admin/users/#{user.id}/login_activities"
        expect(response).to have_http_status(:success)
        expect(response).to render_template("admin/login_activities/index")
      end
    end

    describe "GET /admin/login_activities/:id" do
      it "renders admin login activity page" do
        get "/admin/users/#{user.id}/login_activities"
        expect(response).to have_http_status(:success)
        expect(response).to render_template("admin/login_activities/index")
      end
    end
  end
end
