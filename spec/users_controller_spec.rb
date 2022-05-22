require "rails_helper"

RSpec.describe UsersController, type: :controller do
    before(:each) do
      @user = User.create(name: 'admin', email:'admin@gmail.com', user_type:'Teacher', password: '123')
      session[:user_id] = @user.id
      @class = Classroom.create(name: 'admin', details: '123')
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

        it 'Add user to class' do
            post :UserClassrooms, params:{user_id: @user.id, classroom_id: @class.id}
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
        end

        it 'Update name' do
            patch :update, params:{user:{name:"admin2"}}
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
            @user.reload
            expect(@user.name).to eq("admin2")
        end
    end
end