# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    context 'when there are records' do
      before { create_list(:user, 10) }

      it 'shows 10 users' do
        get '/users', params: {}, as: :json
        expect(!JSON(response.body).empty?).to be(true)
        expect(response).to have_http_status(200)
      end
    end

    context 'when there is no records' do
      it 'shows 0 users' do
        get '/users', params: {}, as: :json
        expect(JSON(response.body).size).to eq(0)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /users' do
    context 'when valid params' do
      let(:params) do
        {
          email: Faker::Internet.email,
          password: 'test1234',
          first_name: Faker::Name.name,
          last_name: Faker::Name.name,
          role: 'test'
        }
      end

      it 'creates a record' do
        post '/users', params: params, as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'PUT /users' do
    context 'when valid params' do
      let(:user) { create(:user) }

      let(:params) { { id: user.id, role: 'app' } }

      it 'updates a record' do
        put "/users/#{user.id}", params: params, as: :json
        expect(response).to have_http_status(200)
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

  describe 'DELETE /users' do
    context 'when valid params' do
      let(:user) { create(:user) }

      it 'deletes a record' do
        delete "/users/#{user.id}", params: {}, as: :json
        expect(response).not_to have_http_status(:unprocessable_entity)
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
