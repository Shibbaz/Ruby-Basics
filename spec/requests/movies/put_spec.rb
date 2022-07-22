# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Movies', type: :request do
  describe 'JSON format' do
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
  end

  describe 'HTML format' do
    describe 'PUT /movies' do
      context 'when valid params' do
        subject { put "/movies/#{movie.id}", params:, as: :html }

        let(:movie) { create(:movie) }

        let(:params) { { id: movie.id, imdb_id: 200 } }

        it 'updates a record' do
          expect(subject).to redirect_to(movie_url(Movie.first))
          expect(response).to have_http_status(:found)
        end
      end
    end
  end

  describe 'Stub Remote IP' do
    describe 'PUT movies' do
      context 'when valid params' do
        let(:movie) { create(:movie) }

        let(:params) { { id: movie.id, imdb_id: 200 } }

        it 'updates a record' do
          put "/movies/#{movie.id}", params:, env: { "REMOTE_ADDR": '168.121.1.1' }, as: :html
          expect(response.body).to eq('Your IP is not on IP While List!')
          expect(response.status).to eq(403)
        end
      end

      context 'when not valid params' do
        let(:params) { { id: 1_000_000 } }

        it 'does not update a record' do
          put '/movies/1000000', params:, env: { "REMOTE_ADDR": '168.121.1.1' }, as: :html
          expect(response.body).to eq('Your IP is not on IP While List!')
          expect(response.status).to eq(403)
        end
      end
    end
  end
end
