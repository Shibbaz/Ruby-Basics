# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Movies', type: :request do
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
