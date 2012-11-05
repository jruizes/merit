module Merit
  class Score
    include Mongoid::Document
    field :category
    field :num_points
    field :log
    belongs_to :sash
  end
end
