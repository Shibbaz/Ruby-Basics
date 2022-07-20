# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe 'Movies', type: :request do
  describe 'GET /movies' do
    context 'when there are records' do
      before { create_list(:movie, 10) }

      it 'shows 10 movies' do
        get '/movies', params: {}, as: :json
        expect(!JSON(response.body).empty?).to be(true)
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
