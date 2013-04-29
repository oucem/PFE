class UsersController < ApplicationController
  # GET /users.json
  def index
    @users = User.where(:company_id => params[:id])#, :except => current_user
    #puts "cuerrenr user///////////////////// #{current_user.email}" 
    respond_to do |format|
    #format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/listuserbygroup/1
  # GET /users/listuserbygroup/1.json
  def listuserbygroup
    @users = User.where(:group_id => params[:id])
    puts  @users.to_json
    respond_to do |format|
    #format.html # index.html.erb
      format.json { render :json => @users }
    end
  end
  
  
  # put /users/group.json
  def add_to_group_as_member

    @user = User.find(params[:_id])

    respond_to do |format|
      if @user[:group_id].nil?
        @user.update_attributes(:group_id => params[:group_id])
        #format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { render :json => @user.to_json, :status => 200 }
      else
      #format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_to_group_as_admin
    @user = User.find(params[:_id])

    respond_to do |format|
      if @user[:group_id].nil? & !@user[:is_ad]
        @user.update_attributes(:group_id => params[:group_id])
        @user.update_attributes(:is_ad => params[:is_ad])
        #format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { render :json => @user.to_json, :status => 200 }
      else
      #format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => 406 }

      end
    end
  end

  # PUT /users/1d
  # PUT /users/1d.json
  def update
    @user = User.find(params[:id])
       @user.update_attributes(params[:user])
        #format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        #format.json { render :json => @user.to_json, :status => 200 }
        render 'show'
        #format.html { render action: "edit" }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
  end

  # PUT /users/delete.json
  def destroy

    @user = User.find(params[:_id])
    respond_to do |format|
      if @user.destroy
        #format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :json => @user.to_json, :status => 200 }
      else
      #format.html { render action: "edit" }
        format.json { render :json=> @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def update_password
    @user = User.find(current_user.id)
    respond_to do |format|
      if @user.update_with_password(params[:user])
        # Sign in the user by passing validation in case his password changed
        sign_in @user, :bypass => true
      format.json { render :json => @user.to_json, :status => 204 }
      else
        render "edit"
      end
    end
  end
end