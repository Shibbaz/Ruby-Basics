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
          user = repository.find(params[:id])
          user.update(params)
          user.reload
        end
      end
    end
  end
end
