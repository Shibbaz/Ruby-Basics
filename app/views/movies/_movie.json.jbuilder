json.extract! movie, :id, :imdb_id, :title, :rating, :rank, :year, :data, :created_at, :updated_at
json.url movie_url(movie, format: :json)
