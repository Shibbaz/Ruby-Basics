require "rails_helper"
require "faker"

RSpec.describe Contexts::Movies::Commands, type: :model do

  context "Contexts::Movies::Commands::Create method" do
    before do
        create(:movie)
    end
    let(:params){
        {    
            imdb_id: Faker::Number.number(digits: 2),
            title: Faker::Name.name,
            rating: Faker::Number.decimal(l_digits: 10),
            rank: Faker::Number.number(digits: 2),
            year: Faker::Number.number(digits: 4),
            data: nil
        }
    }

    it "success" do
        Contexts::Movies::Commands::Create.new.call(params:)
    end
  end

  context "delete! method" do
    before do
        2.times do
            create(:movie)
        end
    end

    context 'deleting a movie' do
        it "success" do
            id = Movie.first.id
            old_size = Movie.all.size
            Contexts::Movies::Commands::Delete.new.call(id)
            new_size = Movie.all.size
            expect(new_size).to eq(old_size-1)
        end

        it "fails" do
            expect{Contexts::Movies::Commands::Delete.new.call(100)}.to raise_error(ActiveRecord::RecordNotFound)
        end
    end
  end

  context "update! method" do
    before do
        create(:movie)
    end
    let(:first_movie) {Movie.first}
    let(:params){
        {    
            id: first_movie.id,
            imdb_id: first_movie.imdb_id,
            title: first_movie.title,
            rating: first_movie.rating,
            rank: first_movie.rank,
            year: first_movie.year,
            data: nil
        }
    }
    context 'updating first movie' do
        it "success" do
            old_year = params[:year]
            params[:year] = 1998
            Contexts::Movies::Commands::Update.new.call(params)
            new_year = Movie.first.year
            expect(new_year).not_to eq(old_year)
        end

        it "fails" do
            old_year = params[:year]
            params[:year] = 1998
            params[:id] = 100
            
            expect{Contexts::Movies::Commands::Update.new.call(params)}.to raise_error(ActiveRecord::RecordNotFound)
        end
    end
  end
end