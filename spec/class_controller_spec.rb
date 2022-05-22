require "rails_helper"

RSpec.describe ClassroomsController, type: :controller do
    before(:each) do
      @user = User.create(name: 'admin', email:'admin@gmail.com', user_type:'Teacher', password: '123')
      session[:user_id] = @user.id
      @class = Classroom.create(name: 'admin', details: '123')
    end

    describe 'Class tests' do
        it 'Create class' do
           post :createClass, params:{classrooms:{name: 'admin132', details: '12213'}}
           data = JSON.parse(response.body)
           expect(response.status).to eq(200)
           expect(Classroom.count).to eq(2)
        end

        it 'Update class' do
            patch :updateClass, params:{id: @class.id, name: 'admin11', details: '113'}
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
            @class.reload
            expect(@class.name).to eq('admin11')
            expect(@class.details).to eq('113')
        end

        it 'Delete class' do
            delete :deleteClass, params:{id: @class.id}
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(Classroom.count).to eq(0)
        end

    end
end