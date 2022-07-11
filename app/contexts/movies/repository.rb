module Contexts
  module Movies
    class Repository
      attr_reader :adapter

      def initialize(adapter: Movie)
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

      def delete_by(id:)
        @adapter.delete_by(id:)
      end
    end
  end
end
