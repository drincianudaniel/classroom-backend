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
           expect(User.count).to eq(2)
        end

        it 'Update password' do
            previous_digest=@user.attributes["password_digest"]
            patch :updatePassword, params:{password: '1234'}
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
            @user.reload
            expect(@user.password_digest).not_to eq(previous_digest)
            expect(@user.authenticate("1234")).not_to eq(false)
        end

        it 'Add user to class' do
            post :addUsertoClass, params:{email: @user.email, classroom_id: @class.id}
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(Userclassroom.count).to eq(1)
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