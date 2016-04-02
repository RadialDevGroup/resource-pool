class AddCandidacyToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :candidacy, :string, default: 'new'
  end
end
