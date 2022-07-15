require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Movies::Commands::Create do
  describe '#call' do
    subject(:command) { described_class.new }

    before do
      create(:movie)
    end

    let(:params) do
      {
        imdb_id: Faker::Number.number(digits: 2),
        title: Faker::Name.name,
        rating: Faker::Number.decimal(l_digits: 10),
        rank: Faker::Number.number(digits: 2),
        year: Faker::Number.number(digits: 4),
        data: nil
      }
    end

    context 'when valid params' do
      it 'creates record' do
        command.call(params:)
      end
    end
  end
end
