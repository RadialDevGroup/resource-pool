require 'rails_helper'

feature "New potential hire" do
  let(:user) { create :user, password: 'password', confirmed_at: Time.now }
  let(:candidate_attributes) { attributes_for :candidate }

  before do
    sign_in user
  end

  scenario "a user creates a new hire" do
    visit new_candidate_path

    fill_in "Name", with: candidate_attributes[:name]
    fill_in "Email", with: candidate_attributes[:email]
    fill_in "Telephone", with: candidate_attributes[:telephone]
    fill_in "LinkedIn", with: candidate_attributes[:linkedin]
    fill_in "Twitter", with: candidate_attributes[:twitter]

    expect do
      click_on "Create Candidate"
    end.to change { Candidate.count }.by 1

    expect(page).to have_content "Candidate created successfully"
  end

  scenario "a user cannot create an invalid new hire" do
    visit new_candidate_path

    fill_in "Name", with: candidate_attributes[:name]

    expect do
      click_on "Create Candidate"
    end.not_to change { Candidate.count }

    expect(page).to have_content "Email can't be blank"
  end
end
