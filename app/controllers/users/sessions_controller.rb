# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
    def create
      self.resource = User.find_for_database_authentication(email: params[:user][:email])
  
      if resource&.valid_password?(params[:user][:password])
        sign_in(resource_name, resource)
        redirect_to root_path, notice: "Signed in successfully."
      else
        flash[:alert] = "Invalid login credentials for this society"
        redirect_to new_user_session_path
      end
    end

    def destroy
        super
    end
  end
  