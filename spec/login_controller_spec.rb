require "rails_helper"

RSpec.describe SessionsController, type: :controller do
    before(:each) do
      @user = User.create(name: 'admin', email:'admin@gmail.com', user_type:'Teacher', password: '123')
    end

    describe 'Login tests' do
        it 'Login with correct credentials' do
            post :create, params:{user:{email:'admin@gmail.com', password: '123'}}
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
        end

        it 'Login with incorrect credentials' do
            post :create, params:{user:{email:'admin123@gmail.com', password: '1234'}}
            data = JSON.parse(response.body)
            expect(response.status).to eq(401)
        end

        it 'Logout test' do
            delete :destroy
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
        end
    end
end