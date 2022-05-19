class AddUserToClassValidator
  include ActiveModel::Validations
  
  attr_accessor :user, :errors

  def initialize(params)
    @errors = []
    @user = nil
  end

  def validate_user
    @user = User.where(email: params[:email]).first
    
    return if @user.present?

    errors << 'Invalid email'
  end

  def classroom_exists
    if Classroom.where(id: params[:classroom_id]).empty?
      errors << 'Classroom does not exist'
    end
  end
end