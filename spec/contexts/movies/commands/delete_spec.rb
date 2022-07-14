require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Movies::Commands::Delete do
  describe 'when method Contexts::Movies::Commands::Delete is used' do
    context '#call' do
      context 'delete! method' do
        before do
          2.times do
            create(:movie)
          end
        end

        subject(:command) do
          described_class.new
        end
        context 'deleting a movie' do
          it 'when valid params' do
            id = Movie.first.id
            old_size = Movie.all.size
            command.call(id)
            new_size = Movie.all.size
            expect(new_size).to eq(old_size - 1)
          end

          it 'when not valid params' do
            expect { command.call(100) }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end
    end
  end
end
