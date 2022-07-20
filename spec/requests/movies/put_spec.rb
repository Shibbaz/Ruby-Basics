# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Movies', type: :request do
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
