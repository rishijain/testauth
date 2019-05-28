class V1::UserAuth
  def initialize(email, password)
    @user = User.find_by email: email
    @password = password
  end

  def authenticate_user
    if @user.nil?
      { message: 'Incorrect email', status: false }
    else
      @user.authenticate(@password) ? message_for_correct_auth : message_for_incorrect_auth
    end
  end

  def message_for_correct_auth
    { message: 'Authenticated', status: true }
  end

  def message_for_incorrect_auth
    { message: 'Incorrect username/password', status: false }
  end
end
