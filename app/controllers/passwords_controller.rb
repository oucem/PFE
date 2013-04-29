class PasswordsController < Devise::PasswordsController
  skip_before_filter :require_no_authentication, only: [:success]


  def create
    self.resource = User.find_by email: params[:user][:email]

    resource.generate_reset_password_token!
    respond_with(resource) do |format|
    UserMailer.reset_pwd(resource).deliver
    format.json { render :json => resource, :status => :created }
    
     #format.json { render :status => 406 }
     
    end
  end

 

  def success
  end

 

  private
  def after_sign_in_path_for(user)
  users_password_success_path
  end
end