require "rails_helper"

RSpec.describe "Pages", type: :request do
  context "when user isn't logged in" do
    describe "GET /" do
      it "returns http success" do
        get "/"
        expect(response).to have_http_status(:success)
      end

      it "renders the home page" do
        get "/"
        expect(response).to render_template("home")
      end
    end

    describe "GET /terms" do
      it "returns http success" do
        get "/terms"
        expect(response).to have_http_status(:success)
      end

      it "renders the terms page" do
        get "/terms"
        expect(response).to render_template("terms")
      end
    end

    describe "GET /privacy" do
      it "returns http success" do
        get "/privacy"
        expect(response).to have_http_status(:success)
      end

      it "renders the privacy page" do
        get "/privacy"
        expect(response).to render_template("privacy")
      end
    end

    describe "GET /about" do
      it "returns http success" do
        get "/about"
        expect(response).to have_http_status(:success)
      end

      it "renders the about page" do
        get "/about"
        expect(response).to render_template("about")
      end    
    end
  end

  context "when user is logged in" do
    include_context :login_user

    describe "GET /" do
      it "returns http success" do
        get "/"
        expect(response).to have_http_status(:success)
      end

      it "renders the customer dashboard page" do
        get "/"
        expect(response).to render_template("customer/dashboard/index")
      end
    end

    describe "GET /terms" do
      it "returns http success" do
        get "/terms"
        expect(response).to have_http_status(:success)
      end

      it "renders the terms page" do
        get "/terms"
        expect(response).to render_template("terms")
      end
    end

    describe "GET /privacy" do
      it "returns http success" do
        get "/privacy"
        expect(response).to have_http_status(:success)
      end

      it "renders the privacy page" do
        get "/privacy"
        expect(response).to render_template("privacy")
      end
    end

    describe "GET /about" do
      it "returns http success" do
        get "/about"
        expect(response).to have_http_status(:success)
      end

      it "renders the about page" do
        get "/about"
        expect(response).to render_template("about")
      end    
    end    
  end
end
