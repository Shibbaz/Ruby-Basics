# frozen_string_literal: true

module Contexts
  module Users
    module Commands
      class Delete
        attr_reader :repository

        def initialize(repository = User)
          @repository = repository
        end

        def call(id)
          repository.destroy(id)
        end
      end
    end
  end
end
