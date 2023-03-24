# frozen_string_literal: true

class Movie
  attr_reader :title,
              :id,
              :vote_avg,
              :runtime,
              :genres,
              :summary,
              :cast,
              :reviews,
              :image

  def initialize(data, cast_data = nil, review_data = nil)
    @title    = data[:original_title]
    @id       = data[:id]
    @vote_avg = data[:vote_average]
    @runtime  = data[:runtime]
    @genres   = data[:genres]
    @summary  = data[:overview]
    @image    = data[:poster_path]
    @cast     = cast_data[:cast].first(10) unless cast_data.nil?
    @reviews  = review_data[:results] unless review_data.nil?
  end
end
