module Contexts
  module Movies
    module Commands
      class Update
        attr_reader :repository

        def initialize(repository = Movie)
          @repository = repository
        end

        def call(params)
          movie ||= repository.find_by(id: params[:id])
          raise ActiveRecord::RecordNotFound if movie.nil?

          movie.update(params)
          movie.reload
        end
      end
    end
  end
end
