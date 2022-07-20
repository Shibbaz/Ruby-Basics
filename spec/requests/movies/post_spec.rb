# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Movies', type: :request do
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
