require "rails_helper"
require "faker"

RSpec.describe Contexts::Movies::Commands::Create do

  context "when method Contexts::Movies::Commands::Create is used" do
    before { create(:movie) }
    subject(:commands){described_class.new}
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

    it "creates record" do
        Contexts::Movies::Commands::Create.new.call(params:)
    end
  end
end