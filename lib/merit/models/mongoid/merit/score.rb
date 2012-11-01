module Merit
  class Score
    include Mongoid::Document
    field :table_name

    # self.table_name = :merit_scores
    belongs_to :sash
    has_many :score_points, :dependent => :destroy, :class_name => 'Merit::Score::Point'

    def points
      score_points.group(:score_id).sum(:num_points).values.first || 0
    end

    class Point
      include Mongoid::Document
      field :table_name
      # self.table_name = :merit_score_points
      belongs_to :score, :class_name => 'Merit::Score'
    end
  end
end
