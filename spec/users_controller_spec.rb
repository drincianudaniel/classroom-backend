require "rails_helper"

RSpec.describe UsersController, type: :controller do
    before(:each) do
      @user = User.create(name: 'admin', email:'admin@gmail.com', user_type:'Teacher', password: '123')
      session[:user_id] = @user.id
    end
    
    describe 'User tests' do
        it 'Create user' do
           post :create, params:{user:{name:'test', email:'test@gmail.com', password: '123', user_type: 'Teacher'}}
           data = JSON.parse(response.body)
           expect(response.status).to eq(200)
        end

        it 'Update password' do
            patch :updatePassword, params:{user:{password: '1234'}}
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
        end

        # it 'Logout test' do
        #     delete :destroy
        #     data = JSON.parse(response.body)
        #     expect(response.status).to eq(200)
        # end
    end
end