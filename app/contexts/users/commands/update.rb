module Contexts
  module Users
    module Commands
      class Update
        attr_reader :repository

        def initialize(repository = User)
          @repository = repository
        end

        def call(params)
          user ||= repository.find_by(id: params[:id])
          raise ActiveRecord::RecordNotFound if user.nil?

          user.update(params)
          user.reload
        end
      end
    end
  end
end
