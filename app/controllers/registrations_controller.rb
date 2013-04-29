# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  @@nbr_user=0
  def new
    super
  end

  def create
    
    @user = User.new(params[:user])
    # Tell the UserMailer to send a welcome Email after save
    if !@user.token.nil?
      UserMailer.welcome_email(@user).deliver#invitation d'un user

      if !@user.group_id.nil?#ajout d'un user dans un group
        @group = Group.find(@user.group_id)
        x= @group.member_nbr+1
        @group.update_attribute(:member_nbr , x)
        if @group.name == "Administration"
          @user.update_attributes(role: '2')
          puts "/*/789456123123456789*/*/"
        end
      else                   #ajout du user ds le group "detached users"
        puts "/*/*/*/*/*/"+@user.group_id.to_s+"--/*/*/*/*/*/*/"
        puts $detached.to_json
        x= $detached.member_nbr+1
        $detached.update_attribute(:member_nbr , x)
        @user.update_attributes(group_id: $detached._id)
      end

    else  #sign_up
      @group= Group.new(name: "Administration",
                            description: "The default group that contain Co-admin agent",
                            member_nbr: 1,
                            company_id: @user.company_id,
                            admin: @user._id  )
      $detached= Group.new(name: "Detached users",
                            description: "A default group that contain users not affected to any group",
                            member_nbr: 0,
                            company_id: @user.company_id,
                            )
      if @group.save#creation d'un group par defaut
        $detached.save
        @user.update_attributes(group_id: @group._id)
        @user.update_attributes(role: '3')
        @user.update_attributes(is_ad: true)
      else
        puts "/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/"
      end
    end
    if @user.save
      puts @user.to_json
      render 'show'
    else
      render :json => @user, :status => 422
    end
  end

  def update
    super
  end
end