class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    #params[:comment{":user_id"=>:session[:id]}]
    @comment = @post.comments.create(params[:comment])

    @comment.user_id = session[:id]
    @comment.update_attributes(params[:comment])



    redirect_to post_path(params[:post_id])
  end
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

  end
  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.user_id = session[:id]

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
