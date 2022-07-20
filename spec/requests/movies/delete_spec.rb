# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Movies', type: :request do
  describe 'GET /movies' do
    context 'when there are records' do
      before { create_list(:movie, 10) }

      it 'shows 10 movies' do
        get '/movies', params: {}, as: :json
        expect(!JSON(response.body).empty?).to be(true)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when there is no records' do
      it 'shows 0 movies' do
        get '/movies', params: {}, as: :json
        expect(JSON(response.body).size).to eq(0)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /movies' do
    context 'when valid params' do
      let(:params) { { imdb_id: 1, title: Faker::Name.name, rating: 10.0, year: 1998, rank: 100, data: nil } }

      it 'creates a record' do
        post '/movies', params: params, as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'PUT /movies' do
    context 'when valid params' do
      let(:movie) { create(:movie) }

      let(:params) { { id: movie.id, imdb_id: 200 } }

      it 'updates a record' do
        put "/movies/#{movie.id}", params:, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'when not valid params' do
      let(:params) { { id: 1_000_000 } }

      it 'does not update a record' do
        put '/movies/1000000', params: params, as: :json
        expect(JSON(response.body)['error'].empty?).to be(false)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /movie' do
    context 'when valid params' do
      let(:movie) { create(:movie) }

      let(:params) { { id: movie.id } }

      it 'deletes a record' do
        delete "/movies/#{movie.id}", params: params, as: :json
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when not valid params' do
      let(:params) { { id: 100_000 } }

      it 'does not delete a record' do
        delete '/movies/100000', params: params, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
