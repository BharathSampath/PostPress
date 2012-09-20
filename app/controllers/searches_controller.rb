class SearchesController < ApplicationController

  # deals with the searches

  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @searches }
    end
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @search = Search.find(params[:id])
    @user_flag=true
    @category_flag=true
    @content_flag=true
    @s_id = session[:search_id]

    if session[:search_id]== "User" then  # if the search is base on the User?
         @user = User.find(:last, :conditions => ["email = ?", @search.content])
         if @user.nil?
           @user_flag=false
         else
           @post  = Post.find(:all, :conditions => ["user_id = ?", @user.id ] )      # get all posts created by the user identified by user's email
         end
    end

    if  session[:search_id] == "Category" then    # if the search is base on the Category?
         @category = Category.find(:last, :conditions => ["name = ?",@search.content])
         if @category.nil?
           @category_flag=false
         else
            @post = Post.find(:all, :conditions => ["category_id = ?", @category.id ] )     # get all posts created identified by post's category
         end

    end
    if session[:search_id] == "Content"  then   # if the search is base on the Content?
         @post  = Post.find(:all, :conditions => ["content LIKE ?", "%#{@search.content}%"])     # get all posts whose content matches with the string entered

         if @post.empty?
           @content_flag=false
         end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searches/new
  # GET /searches/new.json
  def new
    @search = Search.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searches/1/edit
  def edit
    @search = Search.find(params[:id])
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(params[:search])
    session[:search_id] =  params[:search][:id]
    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render json: @search, status: :created, location: @search }
      else
        format.html { render action: "new" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /searches/1
  # PUT /searches/1.json
  def update
    @search = Search.find(params[:id])

    respond_to do |format|
      if @search.update_attributes(params[:search])
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :no_content }
    end
  end
end
