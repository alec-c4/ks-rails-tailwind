require "rails_helper"

RSpec.feature "Authentication", type: :feature do
  scenario "Create account with valid parameters" do
    visit new_user_registration_path
    within("form#new_user") do
      fill_in "user_name", with: "Test User"
      fill_in "user_email", with: "example@example.com"
      fill_in "user_password", with: "Examp1E@examp1e.com"
      fill_in "user_password_confirmation", with: "Examp1E@examp1e.com"
    end

    click_button "Sign up"
    expect(page).to have_content "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."

    open_email("example@example.com")
    visit_in_email("Confirm my account")

    expect(page).to have_content "Your email address has been successfully confirmed"
  end

  scenario "Create account with invalid parameters" do
  end

  scenario "Login with invalid credentials" do
  end

  scenario "Login with valid credentials" do
  end

  scenario "Logout" do
  end
end
