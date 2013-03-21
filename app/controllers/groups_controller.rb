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
  def show
    @group = Group.find(params[:id])
    #@company=Company.find(params[:company_id])
    respond_to do |format|
    # format.html # show.html.erb
    # format.json { render :json => @companies }
      format.json { render :json => @group}
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
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

    respond_to do |format|
      if @group.save
        #format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
      #format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        #format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render json: @group, status: :accepted, location: @group }
      else
      #format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    respond_to do |format|
      @group = Group.find(params[:id])
      if @group.users.length>0
        # format.html { redirect_to @group, notice: 'Group can not be deleted.' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      else
        @group.destroy
        # format.html { redirect_to groups_url }
        format.json { render json: @group, status: :accepted }
      end
    end
  end
end
