# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Users', type: :request do
  describe 'DELETE /users' do
    context 'when valid params' do
      let(:user) { create(:user) }

      it 'deletes a record' do
        delete "/users/#{user.id}", params: {}, as: :json
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when not valid params' do
      let(:params) { { id: 100_000 } }

      it 'does not delete a record' do
        delete '/users/100000', params:, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
