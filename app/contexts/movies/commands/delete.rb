module Contexts
  module Movies
    module Commands
      class Delete
        attr_reader :repository

        def initialize(repository)
          @repository = repository
        end

        def call(id)
          repository.delete_by(id:)
        end
      end
    end
  end
end
