require 'rails_helper'

feature 'Recording the evaluaion state of a candidate' do
  let(:user) { create :user }
  let!(:candidate) { create :candidate }

  before do
    sign_in user
  end

  scenario 'changing the state from "new" to "screened"' do
    visit candidates_path

    within :xpath, "//tr[td[contains(.,\"#{candidate.name}\")]]" do
      expect(page).to have_content 'New'

      click_on 'Screened'
    end

    visit candidates_path

    within :xpath, "//tr[td[contains(.,\"#{candidate.name}\")]]" do
      expect(page).to have_content 'Screened'
    end
  end
end
