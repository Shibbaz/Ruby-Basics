# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Users', type: :request do
  describe 'JSON format' do
    describe 'GET /users' do
      context 'when there are records' do
        before { create_list(:user, 5) }

        it 'shows 5 users' do
          get '/users', params: {}, as: :json
          expect(JSON(response.body).size).to be(5)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when there is no records' do
        it 'shows 0 users' do
          get '/users', params: {}, as: :json
          expect(JSON(response.body).size).to eq(0)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  describe 'HTML format' do
    describe 'GET /users' do
      context 'when there are records' do
        subject { get '/users', params: {}, as: :html }

        before { create_list(:user, 10) }

        it 'shows 5 users' do
          expect(subject).to render_template(:index)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when there is no records' do
        subject { get '/users', params: {}, as: :html }

        it 'shows 0 users' do
          expect(subject).to render_template(:index)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
