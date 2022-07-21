# frozen_string_literal: true

module Contexts
  module Users
    module Commands
      class Update
        attr_reader :repository

        def initialize(repository = User)
          @repository = repository
        end

        def call(params)
          repository.update(params[:id], params)
        end
      end
    end
  end
end
