# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Movies', type: :request do
  describe 'JSON format' do
    describe 'GET /movies' do
      context 'when there are records' do
        before { create_list(:movie, 10) }

        it 'shows 10 movies' do
          get '/movies', params: {}, as: :json
          expect(JSON(response.body).size).to be(5)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when there is no records' do
        it 'shows 0 movies' do
          get '/movies', params: {}, as: :json
          expect(JSON(response.body).size).to eq(0)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  describe 'HTML format' do
    describe 'GET /movies' do
      context 'when there are records' do
        subject { get '/movies', params: {}, as: :html }

        before { create_list(:movie, 5) }

        it 'shows 5 movies' do
          expect(subject).to render_template(:index)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when there is no records' do
        subject { get '/movies', params: {}, as: :html }

        it 'shows 0 movies' do
          expect(subject).to render_template(:index)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  describe 'Stub Remote Ip' do
    describe 'GET /movies' do
      context 'when there are records' do
        before { create_list(:movie, 5) }

        it 'shows 5 movies' do
          get '/movies', params: {}, env: { "REMOTE_ADDR": '168.121.1.1' }, as: :html
          expect(response.body).to eq('Your IP is not on IP While List!')
          expect(response.status).to eq(403)
        end
      end

      context 'when there is no records' do
        it 'shows 0 movies' do
          get '/movies', params: {}, env: { "REMOTE_ADDR": '168.121.1.1' }, as: :html
          expect(response.body).to eq('Your IP is not on IP While List!')
          expect(response.status).to eq(403)
        end
      end
    end
  end
end
