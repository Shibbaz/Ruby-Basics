module Contexts
  module Movies
    module Commands
      class Update
        attr_reader :repository

        def initialize(repository)
          @repository = repository
        end

        def call(params)
          repository.update(params)
        end
      end
    end
  end
end
