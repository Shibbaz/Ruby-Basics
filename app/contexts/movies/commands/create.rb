module Contexts
  module Movies
    module Commands
      class Create
        attr_reader :repository

        def initialize(repository)
          @repository = repository
        end

        def call(params: nil)
          repository.create(params)
        end
      end
    end
  end
end
