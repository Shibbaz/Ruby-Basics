require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Movies::Commands::Delete do
  describe '#call' do
    subject(:command) { described_class.new }

    before { create_list(:movie, 2) }

    context 'when valid params' do
      it 'deletes the record' do
        movie = Movie.first
        movie_title = movie.title
        command.call(movie.id)
        expect(Movie.exists?(title: movie_title)).to eq(false)
      end
    end

    context 'when not valid params' do
      it 'does not delete the record' do
        expect { command.call(100) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
