class Candidate < ActiveRecord::Base
  validates :name, :email, presence: true
  before_create :set_default_candidacy

  enum candidacy: { new: 'new', screened: 'screened', qualified: 'qualified',
    verified: 'verified', closed: 'closed'}, _suffix: true

  def human_candidacy
    candidacy.to_s.humanize
  end

  def set_default_candidacy
    self.candidacy ||= :new
  end
end
