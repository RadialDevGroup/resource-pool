require 'rails_helper'

describe 'Viewing the list of candidates' do
  let!(:candidates) { create_list :candidate, 3  }
  let(:candidate) { candidates.sample }
  let(:user) { create :user, password: 'password', confirmed_at: Time.now }

  before do
    sign_in user
  end

  scenario "a user can see a list of potential candidates" do
    visit root_path

    expect(page).to have_content candidates.first.name
    expect(page).to have_content candidates.first.email
    expect(page).to have_content candidates.first.telephone
  end

  scenario "someone views an individual candidate" do
    visit root_path

    click_link candidate.name, candidate_path(candidate.id)
    expect(page).to have_content candidate.name
    expect(page).to have_content candidate.email
    expect(page).to have_content candidate.telephone
    expect(page).to have_content candidate.linkedin
    expect(page).to have_content candidate.twitter
    expect(page).to have_content candidate.referral_source
  end
end
