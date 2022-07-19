require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Movies::Commands::Update do
  describe '#call' do
    subject(:command) { described_class.new }

    let(:first_movie) { create(:movie) }
    let(:params) { { id: first_movie.id, year: 1988 } }

    context 'when params valid' do
      it 'updates the record' do
        command.call(params)
        expect(first_movie.reload.year).to eq(1988)
      end
    end

    context 'when params not valid' do
      it 'fails updating record' do
        params[:id] = 100

        expect { command.call(params) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
