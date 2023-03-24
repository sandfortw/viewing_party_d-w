require 'rails_helper'


describe 'movie poro', :vcr do
  
  before do
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = ENV['movie_db_token']
    end
    response = conn.get("3/movie/808")
    movie_data = JSON.parse(response.body, symbolize_names: true)
    response = conn.get("3/movie/808/credits?page=1")
    cast_data = JSON.parse(response.body, symbolize_names: true)
    response = conn.get("3/movie/808/reviews")
    review_data = JSON.parse(response.body, symbolize_names: true)
    @movie = Movie.new(movie_data, cast_data, review_data)
    @movie_2 = Movie.new(movie_data)
  end

  it 'attributes with all connections' do
    expect(@movie.title).to be_a(String)
    expect(@movie.title).to eq('Shrek')

    expect(@movie.id).to eq(808)
    expect(@movie.id).to be_an(Integer)

    expect(@movie.vote_avg).to eq(7.718)
    expect(@movie.vote_avg).to be_a(Float)

    expect(@movie.genres).to be_an(Array)

    expect(@movie.summary).to be_a(String)

    expect(@movie.cast).to be_an(Array)
    expect(@movie.cast.count).to eq(10)

    expect(@movie.reviews).to be_an(Array)

    expect(@movie.image).to be_a(String)
  end

  it 'attributes with only one connection' do
    expect(@movie_2.title).to be_a(String)
    expect(@movie_2.title).to eq('Shrek')

    expect(@movie_2.id).to eq(808)
    expect(@movie_2.id).to be_an(Integer)

    expect(@movie_2.vote_avg).to eq(7.718)
    expect(@movie_2.vote_avg).to be_a(Float)

    expect(@movie_2.genres).to be_an(Array)

    expect(@movie_2.summary).to be_a(String)

    expect(@movie_2.cast).to be(nil)

    expect(@movie_2.reviews).to be(nil)

    expect(@movie_2.image).to be_a(String)
  end

end