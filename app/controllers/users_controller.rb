class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html #
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    if session[:id].nil? or session[:role]!="admin"
      redirect_to :action => "homepage"
    end
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      session[:user]=@user
      if(!@user.first_name  && !@user.last_name)
      format.html {redirect_to :action=> "authenticate"}
      else
        @user.Role_id=Role.find(:last,:conditions => ["id = ?",2]).id
      if @user.save
        session[:id]=@user.id
        #redirect_to "/posts"
        format.html { redirect_to "/posts", notice: 'User was successfully created.' }
        #format.json { render json: @user, status: :created, location: @user }
      else
        format.html {redirect_to :action=> "register"}
        #format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
        end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :action => "admin", notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to :action => "admin" }
      format.json { head :no_content }
    end
  end

  def authenticate
    #@user = User.new(params[:userentry])

    valid_user = User.find(:last,:conditions => ["email = ? and pwd = ?",session[:user].email, session[:user].pwd])
    #valid_user = User.find(:last,:conditions => ["email = ? and pwd = ?",@user.email, @user.pwd])
    if valid_user
      session[:id]=valid_user.id
      if valid_user.Role_id == 1
      session[:role]= "admin"
      redirect_to :action => "admin"
      else
      session[:role]= "user"
      redirect_to "/posts"
      end
    else
      reset_session
      respond_to do |format|
        format.html { redirect_to :action => "homepage" ,notice: 'Invalid Username/Password.'}
      end
    end
  end

  def register
    @user = User.new

    respond_to do |format|
      format.html # register.html.erb
      format.json { render json: @users }
    end
  end


  def homepage
    @user = User.new

    respond_to do |format|
      format.html # homepage.html.erb
      format.json { render json: @users }
    end
  end

  def logout
    reset_session
    redirect_to :action => "homepage"
  end
  def admin
    if session[:id].nil? or session[:role]!="admin"
      redirect_to :action => "homepage"
    else
    @user = User.all
    @post = Post.all
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
      end
  end
end
