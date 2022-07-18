require 'rails_helper'
require 'faker'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
  end

  describe 'POST /users' do
    context 'when valid params' do
      it 'creates a record' do
        post '/users.json',
             params: { email: Faker::Internet.email, password: 'test1234', first_name: Faker::Name.name,
                       last_name: Faker::Name.name, role: 'test' }
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'PUT /users' do
    let(:user) { create(:user) }

    context 'when valid params' do
      before do
        put "/users/#{user.id}",
            params: { id: user.id, email: Faker::Internet.email, password: 'test1234', first_name: Faker::Name.name,
                      last_name: Faker::Name.name, role: 'test' }
      end

      it 'updates a record' do
        expect(response).not_to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not valid params' do
      before { put "/users/#{user.id}", params: { id: user.id, role: 'test2' } }

      it 'creates a record' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /users' do
    context 'when valid params' do
      before { create(:user) }

      it 'deletes a record' do
        delete '/users/' + User.first.id.to_s + '.json', params: {}
        expect(response).not_to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not valid params' do
      before { create(:user) }

      it 'does not delete a record' do
        delete '/users/100000.json', params: { id: 100_000 }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
