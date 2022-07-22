# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Users', type: :request do
  describe 'JSON format' do
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

  describe 'HTML format' do
    describe 'DELETE /users' do
      context 'when valid params' do
        subject { delete "/users/#{user.id}", params: {}, as: :html }

        let(:user) { create(:user) }

        it 'deletes a record' do
          expect(subject).to redirect_to(users_url)
          expect(response).to have_http_status(:found)
        end
      end

      context 'when not valid params' do
        subject { delete '/users/100000', params:, as: :html }

        let(:params) { { id: 100_000 } }

        it 'does not delete a record' do
          expect(subject).to render_template(:new)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe 'Stub Remote Ip' do
    describe 'DELETE /users' do
      context 'when valid params' do
        let(:user) { create(:user) }

        it 'deletes a record' do
          delete "/users/#{user.id}", params: {}, env: { "REMOTE_ADDR": '168.121.1.1' }, as: :html
          expect(response.body).to eq('Your IP is not on IP While List!')
          expect(response.status).to eq(403)
        end
      end

      context 'when not valid params' do
        let(:params) { { id: 100_000 } }

        it 'does not delete a record' do
          delete '/users/100000', params:, env: { "REMOTE_ADDR": '168.121.1.1' }, as: :html
          expect(response.body).to eq('Your IP is not on IP While List!')
          expect(response.status).to eq(403)
        end
      end
    end
  end
end
