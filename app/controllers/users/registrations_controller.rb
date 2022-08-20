class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(sign_up_params)
    if user.valid?
      user.save
      render_json('Sign up successfully', { email: user.email })
    else
      render_422(user.errors.full_messages)
    end
  end

  private

  # Default Devise methods for sign up

  # def respond_with(resource, _opts = {})
  #   if resource.persisted?
  #     render_200('Signed up sucessfully.', UserSerializer.new(resource).serializable_hash[:data][:attributes])
  #   else
  #     render_422('There are some issues with sign up.',[resource.errors.full_messages])
  #   end
  # end

  def sign_up_params
    params.require(:user).permit(:email, :password)
  end
end
