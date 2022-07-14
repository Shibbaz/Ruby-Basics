module Contexts
  module Movies
    module Commands
      class Delete
        attr_reader :repository

        def initialize(repository = Movie)
          @repository = repository
        end

        def call(id)
          repository.destroy(id)
        end
      end
    end
  end
end
