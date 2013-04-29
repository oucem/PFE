class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    respond_to do |format|
    #format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def listgroup 
    @groups = Group.where(:company_id => params[:id])
    #@lst= []
    # @groups.each do |group|       
     #   @lst << JSON.parse(group.to_json).merge(member_nbr: group.users.count)
     # end
     # format.json { render :json => @lst } 
    render 'list'
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    respond_to do |format|
    # format.html # show.html.erb
      format.json { render :json => @group}
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new
    respond_to do |format|
     #format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
    
      if !@group.admin.empty?
        @user=User.find(@group.admin)
        puts "///////group controller create//////////"+ @user.to_json
        @user.update_attributes(role: '1')
        @user.update_attributes(group_id: @group._id)
      end
      if @group.save
        puts "############admin.nil######"+ @user.to_json
        #format.html { redirect_to @group, notice: 'Group was successfully created.' }
        render 'show'
      else
        render json: "Error", status: 406
      end
      #format.html { render action: "new" }
       # format.json { render json: @group.errors, status: :unprocessable_entity 
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])
    if !@group.admin.empty?
        @user=User.find(@group.admin)
        puts "///////group controller update//////////"+ @user.to_json
        @user.update_attributes(role: '1')
        @user.update_attributes(group_id: @group._id)
      end
    @group.update_attributes(params[:group])
    #format.html { redirect_to @group, notice: 'Group was successfully updated.' }
    #format.json { render json: @group, status: :accepted, location: @group }
    render 'show'
    #format.html { render action: "edit" }
    #format.json { render json: @group.errors, status: :unprocessable_entity } 
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
      @group = Group.find(params[:id])
      if @group.users.length>0
        # format.html { redirect_to @group, notice: 'Group can not be deleted.' }
       render json: "Group already contains users", status: 412 
      else
        if @group.destroy
          # format.html { redirect_to groups_url }
          render 'show'
        else
          render json: "Error", status: 422 
        end
      end
    end
end
