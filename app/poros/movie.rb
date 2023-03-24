class Movie
  attr_reader :title,
              :id,
              :vote_avg,
              :runtime,
              :genres,
              :summary,
              :cast,
              :reviews
  def initialize(data, cast_data = nil, review_data = nil)
    @title    = data[:original_title]
    @id       = data[:id]
    @vote_avg = data[:vote_average]
    @runtime  = data[:runtime]
    @genres   = data[:genres]
    @summary  = data[:overview]
    @cast     = cast_data[:cast].first(10) if cast_data != nil 
    @reviews  = review_data[:results] if review_data != nil
  end
end