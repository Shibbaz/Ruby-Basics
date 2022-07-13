require "rails_helper"
require "faker"

RSpec.describe Contexts::Users::Commands, type: :model do

  context "Contexts::Users::Commands::Create method" do
    before do
        create(:user)
    end
    let(:params){
        {
            first_name: Faker::Name.name,
            last_name: Faker::Name.name,
            email: Faker::Internet.email ,
            role: "Software Engineer",
            password_digest: Faker::Internet.password
        }
    }

    it "success" do
        Contexts::Users::Commands::Create.new.call(params:)
    end
  end

  context "delete! method" do
    before do
        2.times do
            create(:user)
        end
    end

    context 'deleting a user' do
        it "success" do
            id = User.first.id
            old_size = User.all.size
            Contexts::Users::Commands::Delete.new.call(id)
            new_size = User.all.size
            expect(new_size).to eq(old_size-1)
        end

        it "fails" do
            expect{Contexts::Users::Commands::Delete.new.call(100)}.to raise_error(ActiveRecord::RecordNotFound)
        end
    end
  end

  context "update! method" do
    before do
        create(:user)
    end
    let(:first_user) {User.first}
    let(:params){
        {
            id: first_user.id,
            first_name: Faker::Name.name,
            last_name: Faker::Name.name,
            email: first_user.email,
            role: "Software Engineer"
        }
    }
    context 'updating first user' do
        it "success" do
            old_year = params[:year]
            params[:first_name] = 1998
            Contexts::Users::Commands::Update.new.call(params)
            new_year = User.first.first_name
            expect(new_year).not_to eq(old_year)
        end

        it "fails" do
            params[:id] = 100
            
            expect{Contexts::Users::Commands::Update.new.call(params)}.to raise_error(ActiveRecord::RecordNotFound)
        end
    end
  end
end