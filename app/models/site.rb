class Site < ActiveRecord::Base
  belongs_to :user
  has_many :auditor_participations
  has_many :auditors, through: :auditor_participations, source: :user
  has_many :tester_participations

end
