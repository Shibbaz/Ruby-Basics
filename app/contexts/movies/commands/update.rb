module Contexts
  module Movies
    module Commands
      class Update
        attr_reader :repository

        def initialize(repository = Movie)
          @repository = repository
        end

        def call(params)
          repository.find(params[:id]).update(params)
        end
      end
    end
  end
end
