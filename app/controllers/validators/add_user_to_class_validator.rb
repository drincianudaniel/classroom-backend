class Validations::AddUserToClassValidator
  include ActiveModel::Validations

  validates_presence_of :params[:email], :params[:classroom_id]

  def initialize(params)
    @errors = []
  end

  def validate_user
    @user = User.where(email: params[:email]).first
    
    return if @user.present?

    @errors << 'Invalid email'
  end

  def classroom_exists
    if Classroom.where(id: params[:classroom_id]).empty?
      @errors << 'Classroom does not exist'
    end
  end
end