require 'rails_helper'
require 'faker'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    context 'when there are records' do
      before { create_list(:user, 10) }

      it 'shows 10 users' do
        get '/users',
            params: {}, as: :json
        expect(JSON(response.body).size > 0).to be(true)
      end
    end

    context 'when there is no records' do
      it 'shows 0 users' do
        get '/users',
            params: {}, as: :json
        expect(JSON(response.body).size.equal?(0)).to be(true)
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
        post '/users',
             params: params, as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'PUT /users' do
    context 'when valid params' do
      before { create(:user) }

      let(:params) { { id: User.first.id, role: 'app' } }

      before do
        put "/users/#{User.first.id}", params: params, as: :json
        User.first.reload
      end

      it 'updates a record' do
        expect(response).not_to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not valid params' do
      before { create(:user) }

      let(:params) { { id: 1_000_000 } }

      before do
        put '/users/1000000', params:, as: :json
      end

      it 'does not update a record' do
        expect(JSON(response.body)['message'].empty?).to be(false)
      end
    end
  end

  describe 'DELETE /users' do
    context 'when valid params' do
      before { create(:user) }

      it 'deletes a record' do
        delete "/users/#{User.first.id}", params: {}, as: :json
        expect(response).not_to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not valid params' do
      before { create(:user) }

      let(:params) { { id: 100_000 } }

      it 'does not delete a record' do
        delete '/users/100000', params:, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
