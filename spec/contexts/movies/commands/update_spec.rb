require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Movies::Commands::Update do
  describe 'when method Contexts::Movies::Commands::Update is used' do
    context '#call' do
      before do
        create(:movie)
      end

      subject(:command) do
        described_class.new
      end
      let(:first_movie) { Movie.first }
      let(:params) do
        {
          id: first_movie.id,
          imdb_id: first_movie.imdb_id,
          title: first_movie.title,
          rating: first_movie.rating,
          rank: first_movie.rank,
          year: first_movie.year,
          data: nil
        }
      end
      context 'when valid params' do
        it 'updates record' do
          old_year = params[:year]
          params[:year] = 1998
          command.call(params)
          new_year = Movie.first.year
          expect(new_year).not_to eq(old_year)
        end
      end
      context 'when not valid params' do
        it 'fails updating record' do
          old_year = params[:year]
          params[:year] = 1998
          params[:id] = 100

          expect { command.call(params) }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end