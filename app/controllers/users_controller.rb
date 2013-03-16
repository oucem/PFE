class UsersController < ApplicationController
 
 # GET /users.json
  def index
    @users = User.all

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
end