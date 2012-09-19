class CommentvotesController < ApplicationController
  def new
   @post = Post.find(params[:post_id])
   @comment = Comment.find(params[:comment_id])
   @commentvote = @comment.commentvotes.find(:all, :conditions => {:comment_id => @comment.id})
   @flag = true
   @display_flag=0
   if @comment.user_id == session[:id]  or session[:id].nil?
       @display_flag=1
       @flag = false
   end
   @commentvote.each do |commentvote|
       if commentvote.user_id == session[:id]
          @flag = false
       end
   end
   if @flag == true then
   @commentvote = @comment.commentvotes.create(params[:comment])
   @commentvote.user_id = session[:id]

   @commentvote.update_attributes(params[:comment])
   @post.updated_at=Time.now
   @post.update_attributes(params[:post])
   redirect_to @post
   end


  end
  def update
    @comment = Comment.find(params[:comment_id])
    @commentvote = @comment.commentvotes.find(params[:comment])
    @commentvote.user_id = session[:id]
    respond_to do |format|
      if  @commentvote.update_attributes(params[:commentvote])
        format.html { redirect_to @post, notice: 'Vote was successfully saved' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  def index
    @comment = Comment.find(params[:comment_id])
    @commentvote = @comment.commentvotes.find(:all, :conditions => {:comment_id => @comment.id})
  end
end
