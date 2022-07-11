module Contexts
  module Users
    class Repository
      attr_reader :adapter

      def initialize(adapter: User)
        @adapter = adapter
      end

      def create(params)
        @adapter.new(params)
      end

      def find(id)
        @adapter.find(id)
      end

      def update(params)
        @adapter.find(params[:id]).update(params)
      end
    end
  end
end
