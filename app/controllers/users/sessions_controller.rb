class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by(email: sign_in_params[:email].downcase)
    if user && user.valid_password?(sign_in_params[:password])
      sign_in(user)
      p "current_user: #{current_user.inspect}"
      render_json('Sign in successfully', { email: user.email, token: request.env['warden-jwt_auth.token'] })
    else
      render json: { status: 'Non-Authoritative Information', message: ['You entered in an incorrect email or password,please try again.'], data: [], status_code: 203, messageType: 'error' },
             status: 203
    end
  end

  def destroy
    sign_out(current_user)
    render_json('Logout successfully')
  end

  private

  # Default Devise methods for sign in and log out

  # def respond_with(resource, _opts = {})
  #   render_200('Sign in sucessfully.',{ data: UserSerializer.new(resource).serializable_hash[:data][:attributes], token: request.env['warden-jwt_auth.token'] } )
  # end

  # def respond_to_on_destroy
  #   if current_user
  #     render_200("Logout successfully!")
  #   else
  #     render_401
  #   end
  # end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
