require 'rails_helper'

feature "Track referrals" do
  let!(:user) { create :user }

  before do
    sign_in user
  end

  scenario "creating a candidate with a referral source" do
    visit new_candidate_path

    fill_in "Name", with: "My Friend"
    fill_in "Email", with: "my-friends-email@example.com"

    fill_in "Referral source", with: "myself"
    expect do
      click_on "Create Candidate"
    end.to change { Candidate.first.referral_source rescue nil }
  end

  context "with an existing candidate" do
    let(:candidate) { create :candidate }
    
    scenario "creating a candidate with a referral source" do
      visit edit_candidate_path candidate

      fill_in "Name", with: "My Friend"
      fill_in "Email", with: "my-friends-email@example.com"

      fill_in "Referral source", with: "myself"

      expect do
        click_on "Update Candidate"
      end.to change { candidate.reload.referral_source }.to 'myself'

      expect(page).to have_content "Candidate updated successfully"
    end

    scenario "while making the model invalid" do
      visit edit_candidate_path candidate

      fill_in "Name", with: nil
      fill_in "Email", with: "my-friends-email@example.com"

      fill_in "Referral source", with: "myself"

      expect do
        click_on "Update Candidate"
      end.not_to change { candidate.reload.referral_source }

      expect(page).to have_content "Name can't be blank"
    end
  end
end
