# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Users', type: :request do
  describe 'JSON format' do
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
  end

  describe 'HTML format' do
    describe 'POST /users' do
      context 'when valid params' do
        subject { post '/users', params:, as: :html }

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
          expect(subject).to redirect_to(user_url(User.first))
        end
      end
    end
  end
end
