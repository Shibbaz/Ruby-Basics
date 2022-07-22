# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Movies', type: :request do
  describe 'JSON format' do
    describe 'POST /movies' do
      context 'when valid params' do
        let(:params) { { imdb_id: 1, title: Faker::Name.name, rating: 10.0, year: 1998, rank: 100, data: nil } }

        it 'creates a record' do
          post '/movies', params: params, as: :json
          expect(response).to have_http_status(:created)
        end
      end
    end
  end

  describe 'HTML format' do
    describe 'POST /movies' do
      context 'when valid params' do
        subject { post '/movies', params:, as: :html }

        let(:params) { { imdb_id: 1, title: Faker::Name.name, rating: 10.0, year: 1998, rank: 100, data: nil } }

        it 'creates a record' do
          expect(subject).to redirect_to(movie_url(Movie.first))
        end
      end
    end
  end

  describe 'Stub Remote Ip' do
    describe 'POST /movies' do
      context 'when valid params' do
        let(:params) { { imdb_id: 1, title: Faker::Name.name, rating: 10.0, year: 1998, rank: 100, data: nil } }

        it 'creates a record' do
          post '/movies', params:, env: { "REMOTE_ADDR": '168.121.1.1' }, as: :html
          expect(response.body).to eq('Your IP is not on IP While List!')
          expect(response.status).to eq(403)
        end
      end
    end
  end
end
