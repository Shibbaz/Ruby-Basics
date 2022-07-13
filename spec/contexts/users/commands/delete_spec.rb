require "rails_helper"
require "faker"

RSpec.describe Contexts::Users::Commands::Delete do
    context "when method Contexts::Users::Commands::Deletex is used" do
        before do
            2.times do
                create(:user)
            end
        end
        subject(:command){
            described_class.new
        }
        context 'deleting a user' do
            it "deletes record" do
                id = User.first.id
                old_size = User.all.size
                command.call(id)
                new_size = User.all.size
                expect(new_size).to eq(old_size-1)
            end

            it "fails deleting record" do
                expect{command.call(100)}.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end
end
