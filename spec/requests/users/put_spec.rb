# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Users', type: :request do
  describe 'PUT /users' do
    context 'when valid params' do
      let(:user) { create(:user) }

      let(:params) { { id: user.id, role: 'app' } }

      it 'updates a record' do
        put "/users/#{user.id}", params: params, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not valid params' do
      let(:params) { { id: 1_000_000 } }

      it 'does not update a record' do
        put '/users/1000000', params:, as: :json
        expect(JSON(response.body)['error'].empty?).to be(false)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
