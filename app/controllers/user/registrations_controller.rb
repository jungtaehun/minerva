class User::RegistrationsController < Devise::RegistrationsController
  #before_action :configure_sign_up_params, only: [:create, :new]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    if notice == nil
      redirect_to new_user_session_path
    else
      user_check = User.where(:student_id => notice[1]).count
      if user_check >= 1
        respond_to do |format|
          format.html {redirect_to new_user_session_path, notice: 'duplicated'}
        end
      elsif user_check == 0
        super
      end
    end
  end

  # POST /resource
  # def create
  #   super
  # end

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

  #protected

  # If you have extra params to permit, append them to the sanitizer.
  #def configure_sign_up_params
  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:hakbun])
  #end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
