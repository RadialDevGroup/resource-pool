class Candidate < ActiveRecord::Base
  validates :name, :email, presence: true
end
