require "rails_helper"

RSpec.feature "Profile Managements", type: :feature do
  include_context :capybara_login_user

  scenario "Update profile with correct params" do
    visit edit_profile_path
    within("form#profile_form") do
      fill_in "First name", with: "Jeff"
      fill_in "Last name", with: "Bezos"
    end
    click_button "Update profile"

    expect(page).to have_content "Profile update successful"
  end

  scenario "Update profile with incorrect params" do
    visit edit_profile_path
    within("form#profile_form") do
      fill_in "First name", with: ""
      fill_in "Last name", with: ""
    end
    click_button "Update profile"

    expect(page).to have_content "Profile update failed"
  end
end
