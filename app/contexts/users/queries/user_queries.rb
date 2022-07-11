# Query Object
module Contexts
  module Users
    module Queries
      class UserQueries
        attr_reader :users

        def initialize(users = User.all)
          @users = users
        end

        def all
          @users
        end

        def find_by(params)
          @users.find_by(params)
        end

        def where(params)
          @users.where(params)
        end

        def by_role(order)
          @users.order(role: order)
        end
      end
    end
  end
end
