# Query Object
module Contexts
  module Movies
    module Queries
      class MovieQueries
        attr_reader :movies

        def initialize(movies = Movie.all)
          @movies = movies
        end

        def all
          @movies
        end

        def find_by(params)
          movies.find_by(params)
        end

        def where(params)
          @movies.where(params)
        end

        def by_year(order)
          @movies.order(year: order)
        end

        def by_rank(rank)
          @movies.order(rank:)
        end
      end
    end
  end
end
