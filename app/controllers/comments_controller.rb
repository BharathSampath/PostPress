class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    #params[:comment{":user_id"=>:session[:id]}]
    @comment = @post.comments.create(params[:comment])

    @comment.user_id = session[:id]
    @comment.update_attributes(params[:comment])
    @post.updated_at=Time.now
    @post.update_attributes(params[:post])


    redirect_to post_path(params[:post_id])
  end
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      if  session[:role] == "admin"
        format.html { redirect_to :controller => "users" , :action => "admin" }
        format.json { head :no_content }
      else
        format.html {  redirect_to post_path(@post)}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end
  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

  end
  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.user_id = session[:id]
    @post.updated_at=Time.now
    @post.update_attributes(params[:post])
    respond_to do |format|
      if  @comment.update_attributes(params[:comment])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
end
