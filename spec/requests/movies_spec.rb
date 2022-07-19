require 'rails_helper'
require 'faker'

RSpec.describe 'Movies', type: :request do
  describe 'GET /movies' do
    context 'when there are records' do
      before { create_list(:movie, 10) }

      it 'shows 10 movies' do
        get '/movies',
            params: {}, as: :json
        expect(JSON(response.body).size > 0).to be(true)
      end
    end

    context 'when there is no records' do
      it 'shows 0 movies' do
        get '/movies',
            params: {}, as: :json
        expect(JSON(response.body).size.equal?(0)).to be(true)
      end
    end
  end

  describe 'POST /movies' do
    context 'when valid params' do
      let(:params) { { imdb_id: 1, title: Faker::Name.name, rating: 10.0, year: 1998, rank: 100, data: nil } }

      it 'creates a record' do
        post '/movies',
             params: params, as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'PUT /movies' do
    context 'when valid params' do
      before { create(:movie) }

      let(:params) { { id: Movie.first.id, imdb_id: 200 } }

      before do
        put "/movies/#{Movie.first.id}", params:, as: :json
      end

      it 'updates a record' do
        expect(response).not_to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not valid params' do
      before { create(:movie) }

      let(:params) { { id: 1_000_000 } }

      it 'does not update a record' do
        put '/movies/1000000', params: params, as: :json
        expect(JSON(response.body)['message'].empty?).to be(false)
      end
    end
  end

  describe 'DELETE /movie' do
    context 'when valid params' do
      before { create(:movie) }

      let(:params) { { id: Movie.first.id } }

      it 'deletes a record' do
        delete "/movies/#{Movie.first.id}", params: params, as: :json
        expect(response).not_to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not valid params' do
      before { create(:movie) }

      let(:params) { { id: 100_000 } }

      it 'does not delete a record' do
        delete '/movies/100000', params: params, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
