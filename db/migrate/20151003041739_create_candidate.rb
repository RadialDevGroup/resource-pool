class CreateCandidate < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.string :telephone
      t.string :linkedin
      t.string :twitter
    end
  end
end
