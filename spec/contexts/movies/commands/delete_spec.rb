require "rails_helper"
require "faker"

RSpec.describe Contexts::Movies::Commands::Delete do

  context "when method Contexts::Movies::Commands::Delete is used" do
    context "delete! method" do
        before do
            2.times do
                create(:movie)
            end
        end

        subject(:command){
            described_class.new
        }
        context 'deleting a movie' do
            it "deletes record" do
                id = Movie.first.id
                old_size = Movie.all.size
                Contexts::Movies::Commands::Delete.new.call(id)
                new_size = Movie.all.size
                expect(new_size).to eq(old_size-1)
            end
      
            it "fails deleting record" do
                expect{Contexts::Movies::Commands::Delete.new.call(100)}.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
      end
    end
end