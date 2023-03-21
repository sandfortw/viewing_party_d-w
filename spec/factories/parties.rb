FactoryBot.define do
  factory :party do
    date { "2023-03-20" }
    time { "2023-03-20 19:01:44" }
    duration { 1 }
    host_id { 1 }
    movie_id { 1 }
  end
end
