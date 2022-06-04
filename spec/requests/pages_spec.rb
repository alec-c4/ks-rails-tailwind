require "rails_helper"

RSpec.describe "Pages", type: :request do
  context "when user isn't logged in" do
    describe "GET /" do
      it "renders the home page" do
        get root_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template("home")
      end
    end

    describe "GET /terms" do
      it "renders the terms page" do
        get terms_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template("terms")
      end
    end

    describe "GET /privacy" do
      it "renders the privacy page" do
        get privacy_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template("privacy")
      end
    end

    describe "GET /about" do
      it "renders the about page" do
        get about_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template("about")
      end
    end
  end

  context "when user is logged in" do
    include_context :login_user

    describe "GET /" do
      it "renders the customer dashboard page" do
        get root_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template("customer/dashboard/index")
      end
    end

    describe "GET /terms" do
      it "renders the terms page" do
        get terms_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template("terms")
      end
    end

    describe "GET /privacy" do
      it "renders the privacy page" do
        get privacy_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template("privacy")
      end
    end

    describe "GET /about" do
      it "renders the about page" do
        get about_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template("about")
      end
    end
  end
end
