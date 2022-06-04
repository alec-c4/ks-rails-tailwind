require "rails_helper"

RSpec.describe "Admin::Users", type: :request do
  let(:user) { create(:user) }

  context "when user isn't logged in" do
    describe "GET /admin/users" do
      it "redirects to the root_path with http status 302" do
        get admin_users_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET /admin/users/:id" do
      it "redirects to the root_path with http status 302" do
        get admin_user_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET /admin/users/:id/edit" do
      it "redirects to the root_path with http status 302" do
        get edit_admin_user_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when user is logged in" do
    include_context :login_user

    describe "GET /admin/users" do
      it "redirects to the root_path with http status 302" do
        get admin_users_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET /admin/users/:id" do
      it "redirects to the root_path with http status 302" do
        get admin_user_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET /admin/users/:id/edit  (logged in user)" do
      it "redirects to the root_path with http status 302" do
        get edit_admin_user_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when user is logged in with role :admin" do
    include_context :login_admin

    describe "GET /admin/users" do
      it "renders users administration page" do
        get admin_users_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template("admin/users/index")
      end
    end

    describe "GET /admin/users/:id" do
      it "renders show user page" do
        get admin_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response).to render_template("admin/users/show")
      end
    end

    describe "GET /admin/users/:id/edit" do
      it "renders edit user page" do
        get edit_admin_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response).to render_template("admin/users/edit")
      end
    end
  end
end
