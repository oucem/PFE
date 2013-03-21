# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  def new
    super
  end

  def create
    @user = User.new(params[:user])
    puts "cuerrenr user #{@user}"
    puts "email = #{@user.email}"
    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome Email after save
        if !@user.token.nil?
          puts "achref"
          UserMailer.welcome_email(@user).deliver
        end
        #format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        puts "houssem"
        #format.html { render :action => "new" }
        format.json { render :status => 422 }
      end
    end
  end

  def update
    super
  end
end