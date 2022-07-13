module Contexts
  module Users
    module Commands
      class Delete
        attr_reader :repository

        def initialize(repository = User)
          @repository = repository
        end

        def call(id)
          repository.find(id)
          repository.delete_by(id:)
        end
      end
    end
  end
end
