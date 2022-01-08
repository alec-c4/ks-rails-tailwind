require "rails_helper"

RSpec.describe "Users::Profiles", type: :request do
  let(:valid_attributes) {
    {
      first_name: "Steve",
      last_name: "Jobs",
      time_zone: "Moscow"
    }
  }

  let(:invalid_attributes) {
    {
      first_name: nil,
      last_name: nil,
      time_zone: nil
    }
  }

  context "when user isn't logged in" do
    describe "GET /edit" do
      it "redirects to sign_in page" do
        get "/users/profiles/edit"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT /edit" do
      it "redirects to sign_in page" do
        expect { put "/users/profiles/edit" }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  context "when user is logged in" do
    include_context :login_user

    describe "GET /edit" do
      it "returns http success" do
        get "/users/profiles/edit"
        expect(response).to have_http_status(:success)
        expect(response).to render_template("users/profiles/edit")
      end
    end

    describe "PUT /edit" do
      it "returns http success (valid attributes)" do
        put "/users/profiles", params: {user: valid_attributes}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(edit_profile_path)

        expect(user.name).to eq("Steve Jobs")
        expect(user.time_zone).to eq("Moscow")
        expect(user).to be_valid
      end

      it "returns http success (invalid attributes)" do
        put "/users/profiles", params: {user: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template("users/profiles/edit")

        expect(user).to_not be_valid
      end
    end
  end
end
