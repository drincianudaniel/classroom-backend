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
            post :is_logged_in?
            data = JSON.parse(response.body)
            expect(data["logged_in"]).to eq(true)
        end

        it 'Login with incorrect credentials' do
            post :create, params:{user:{email:'admin123@gmail.com', password: '1234'}}
            data = JSON.parse(response.body)
            expect(response.status).to eq(401)
            post :is_logged_in?
            data = JSON.parse(response.body)
            expect(data["logged_in"]).to eq(false)
        end

        it 'Logout test' do
            session[:user_id] = @user.id
            post :is_logged_in?
            data = JSON.parse(response.body)
            expect(data["logged_in"]).to eq(true)
            delete :destroy
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
            post :is_logged_in?
            data = JSON.parse(response.body)
            expect(data["logged_in"]).to eq(false)
        end
    end
end