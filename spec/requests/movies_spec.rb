require 'rails_helper'
require 'faker'

RSpec.describe 'Movies', type: :request do
  describe 'GET /movies.json' do
  end

  describe 'POST /movies' do
    context 'when valid params' do
      it 'creates a record' do
        post '/movies.json',
             params: { imdb_id: 1, title: Faker::Name.name, rating: 10.0, year: 1998, rank: 100, data: nil }
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'PUT /movies' do
    context 'when valid params' do
      before { create(:movie) }

      before do
        put "/movies/#{Movie.first.id}.json",
            params: { id: Movie.first.id, imdb_id: 1, title: 'kangoroo', rating: 10.0, year: 1998, rank: 100,
                      data: nil }
      end

      it 'updates a record' do
        expect(response).not_to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not valid params' do
      before { create(:movie) }

      before { put "/movies/#{Movie.first.id}", params: { id: Movie.first.id, year: 10.5 } }

      it 'creates a record' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /movie' do
    context 'when valid params' do
      before { create(:movie) }

      it 'deletes a record' do
        delete "/movies/#{Movie.first.id}.json", params: { id: Movie.first.id }
        expect(response).not_to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not valid params' do
      before { create(:movie) }

      it 'does not delete a record' do
        delete '/movies/100000.json', params: { id: 100_000 }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
