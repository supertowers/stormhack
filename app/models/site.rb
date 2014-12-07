class Site < ActiveRecord::Base
  belongs_to :user
  has_many :auditor_participations
  has_many :auditors, through: :auditor_participations, source: :user
  has_many :tester_participations
  has_many :vulnerabilities

  mount_uploader :screenshot, ScreenshotUploader

  before_validation :smart_add_url_protocol

  include AASM

  aasm :column => 'status' do
    state :created, :initial => true
    state :verified
    state :closed

    event :verify do
      transitions :from => :created, :to => :verified
    end

    event :close do
      transitions :from => [:created, :verified], :to => :closed
    end
  end

  def is_suscribed?(user)
    if (user)
      TesterParticipation.where(user_id: user.id, site_id: self.id).length > 0
    end
  end

  def to_s
    url
  end

  private
    def smart_add_url_protocol
      unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
        self.url = "http://#{self.url}"
      end
    end
end
