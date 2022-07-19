# frozen_string_literal: true

module Contexts
  module Users
    module Commands
      class Create
        attr_reader :repository

        def initialize(repository = User)
          @repository = repository
        end

        def call(params: nil)
          repository.create(params)
        end
      end
    end
  end
end
