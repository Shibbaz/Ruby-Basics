# frozen_string_literal: true

module Contexts
  module Movies
    module Commands
      class Update
        attr_reader :repository

        def initialize(repository = Movie)
          @repository = repository
        end

        def call(params)
          repository.update(params[:id], params)
        end
      end
    end
  end
end
