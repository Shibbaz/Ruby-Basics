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
          expect(JSON(response.body).size).to be(10)
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

        before { create_list(:movie, 10) }

        it 'shows 10 movies' do
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
end
