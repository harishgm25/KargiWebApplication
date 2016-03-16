class Users::RegistrationsController < Devise::RegistrationsController

respond_to :html,:json
 
  before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
   def create

       @user = User.new sign_up_params
       @user.build_profile
       if @user.save
          puts "---------------------------------------"
          puts request.format
            respond_to do |format|
              if(request.format == "text/html")
                 format.html { redirect_to after_update_path_for(@user) }
                 
              else
                return render :json => {:token => @user.authentication_token, :userid => ""+@user._id,  :success => true, :email => @user.email, :roll => @user.roll}
              end
            end
        else
             
                respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

   #If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :mobile,:roll, :password, :password_confirmation, :remember_me) }
  end

   
  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :mobile,:roll,:password, :password_confirmation, :current_password) }
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
