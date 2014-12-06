class Site < ActiveRecord::Base
  belongs_to :user
  has_many :auditor_participations
  has_many :auditors, through: :auditor_participations, source: :user
  has_many :tester_participations

  before_validation :smart_add_url_protocol

  private
    def smart_add_url_protocol
      unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
        self.url = "http://#{self.url}"
      end
    end
end
