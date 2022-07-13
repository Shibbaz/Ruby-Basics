require "rails_helper"
require "faker"

RSpec.describe Contexts::Users::Commands::Update do
    context "when method Contexts::Users::Commands::Update is used" do
        before do
            create(:user)
        end
        let(:first_user) {User.first}
        subject(:command){
            described_class.new
        }
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
            it "updates record" do
                old_year = params[:year]
                params[:first_name] = 1998
                command.call(params)
                new_year = User.first.first_name
                expect(new_year).not_to eq(old_year)
            end

            it "fails updating record" do
                params[:id] = 100
                
                expect{command.call(params)}.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end
end