# frozen_string_literal: true

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
          movies
        end

        delegate :find_by, to: :movies

        delegate :where, to: :movies

        def by_year(order)
          movies.order(year: order)
        end

        def by_rank(rank)
          movies.order(rank:)
        end
      end
    end
  end
end
