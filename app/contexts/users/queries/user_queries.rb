# frozen_string_literal: true

# Query Object
module Contexts
  module Users
    module Queries
      class UserQueries
        attr_reader :users

        def initialize(users = User.all)
          @users = users
        end

        def all(page:)
          users.paginate(page:)
        end

        delegate :find_by, to: :users

        delegate :where, to: :users

        def by_role(order)
          users.order(role: order)
        end
      end
    end
  end
end
