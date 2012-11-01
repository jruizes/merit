class BadgesSash
  include Mongoid::Document
  include Mongoid::Timestamps

  field :badge_id
  belongs_to :sash

  def badge
    Badge.find(badge_id)
  end

  # To be used in the application, mark badge granting as notified to user
  def set_notified!
    self.notified_user = true
    save
  end
end
