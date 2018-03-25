class Users::SessionsController < Devise::SessionsController

	def create  
		respond_to do |format|  
			format.html { super }  
			format.json {  
				warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")  
				render :status => 200, :json => { :status => "Success" }  
			}  
		end  
	end  

	
	# post /users/confirm_auth
	# A simple action to confirm an entered password for a user who is already signed in
	def confirm_auth
		if current_user.valid_password?(params[:password])
			tok = SecureRandom.uuid
			session[:pw_token]  = tok
			session[:pw_timestamp] = Time.current.to_s
			render json: {token: tok}, status: :ok
		else
			render json: ["Incorrect password. Please enter your #{Settings.general.name} %> password."], status: :unprocessable_entity
		end
  end
	
end

