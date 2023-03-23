class TopMovie
  attr_reader :original_title,
              :vote_average

  def initialize(attributes)
    @title = attributes[:original_title]
    @vote_avg = attributes[:vote_average]
  end
end