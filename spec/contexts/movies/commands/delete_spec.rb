require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Movies::Commands::Delete do
  describe '#call' do
<<<<<<< HEAD
=======
    before do
      create(:movie)
      create(:movie)
    end

>>>>>>> 0e76163f90506d8433de5d519186a5a8333cb86f
    subject(:command) do
      described_class.new
    end

    before do
      create_list(:movie, 2)
    end

    context 'when valid params' do
      it 'deletes the record' do
        id = Movie.first.id
        old_size = Movie.all.size
        command.call(id)
        new_size = Movie.all.size
        expect(new_size).to eq(old_size - 1)
      end
    end

    context 'when not valid params' do
      it 'does not delete the record' do
        expect { command.call(100) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
