# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Users', type: :request do
  describe 'PUT /users' do
    describe 'JSON format' do
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

      context 'when not valid params' do
        subject { put '/users/1000000', params:, as: :json }

        let(:user) { create(:user) }

        let(:params) { { id: user.id, role: 'app' } }

        it 'updates a record' do
          subject
          expect(JSON(response.body)['error'].empty?).to be(false)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'HTML format' do
      context 'when valid params' do
        subject { put "/users/#{user.id}", params:, as: :html }

        let(:user) { create(:user) }

        let(:params) { { id: user.id, role: 'app' } }

        it 'updates a record' do
          expect(subject).to redirect_to(user_url(User.first))
        end
      end

      context 'when not valid params' do
        subject { put '/users/1000000', params:, as: :html }

        let(:user) { create(:user) }

        let(:params) { { id: user.id, role: 'app' } }

        it 'updates a record' do
          expect(subject).to render_template(:edit)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe 'Stub Remote Ip' do
    context 'when valid params' do
      let(:user) { create(:user) }

      let(:params) { { id: user.id, role: 'app' } }

      it 'updates a record' do
        put "/users/#{user.id}", params:, env: { "REMOTE_ADDR": '168.121.1.1' }, as: :html
        expect(response.body).to eq('Your IP is not on IP While List!')
        expect(response.status).to eq(403)
      end
    end

    context 'when not valid params' do
      let(:user) { create(:user) }

      let(:params) { { id: user.id, role: 'app' } }

      it 'updates a record' do
        put '/users/1000000', params:, env: { "REMOTE_ADDR": '168.121.1.1' }, as: :html
        expect(response.body).to eq('Your IP is not on IP While List!')
        expect(response.status).to eq(403)
      end
    end
  end
end
