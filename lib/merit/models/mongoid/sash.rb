class Sash
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :badges_sashes, :dependent => :destroy
  has_many :scores, :dependent => :destroy, :class_name => 'Merit::Score'

  alias :points :scores

  def badges
    badge_ids badges_sashes.map(&:badge_id)
    badge_ids.collect { |b_id| Badge.find(b_id) }
  end

  def add_badge(badge_id)
    bs = BadgesSash.new
    bs.badge_id = badge_id
    self.badges_sashes << bs
  end

  def rm_badge(badge_id)
    badges_sashes.find_by_badge_id(badge_id).try(:destroy)
  end

  def sum_points(category)
    if category
      scores.where(:category => category).sum(:num_points)
    else
      scores.sum(:num_points)
    end
  end

  def add_points(num_points, log = 'Manually granted through `add_points`', category = 'default')
    point = Merit::Score.new(log: log,
                             num_points: num_points,
                             category: category)
    self.scores << point
  end

  def substract_points(num_points, log = 'Manually granted through `add_points`', category = 'default')
    add_points -num_points, log, category
  end
end
