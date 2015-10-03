require 'rails_helper'

feature "A User can login" do
  let(:user) { create :user, password: 'password', confirmed_at: Time.now }

  before do
    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: 'password'

    click_on "Log in"
  end

  scenario "a user logs in" do
    expect(page).to have_content "Signed in successfully."
  end

  scenario "a user logs in" do
    visit root_path

    click_on "Log out"
  end
end
