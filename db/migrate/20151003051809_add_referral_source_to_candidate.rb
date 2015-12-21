class AddReferralSourceToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :referral_source, :string
  end
end
