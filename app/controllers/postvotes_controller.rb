class PostvotesController < ApplicationController

  # deals with the votes for the posts

   def new
     @post = Post.find(params[:post_id])
     @postvote = @post.postvotes.find(:all, :conditions => {:post_id => @post.id})
     @flag = true
     @display_flag=0
     if @post.user_id == session[:id]  or session[:id].nil?      # restricts the users to access unauthorized pages by manually typing in the page-link AND
                                                                 # doesn't allow users to vote for their own post
       @flag = false
       @display_flag=1
     end
     @postvote.each do |postvote|
         if postvote.user_id == session[:id]
          @flag = false
         end
     end
     if @flag == true then
     @postvote = @post.postvotes.create(params[:post])
     @postvote.user_id = session[:id]
     @postvote.update_attributes(params[:postvote])
     @post.updated_at=Time.now
     @post.update_attributes(params[:post])
     redirect_to @post
     end
   end

   def update
     @post = Post.find(params[:post_id])
     @postvote = @post.postvotes.find(params[:post])
     @postvote.user_id = session[:id]
     respond_to do |format|
       if  @postvote.update_attributes(params[:postvote])
         format.html { redirect_to @post, notice: 'Vote was successfully saved' }
         format.json { head :no_content }
       else
         format.html { render action: "edit" }
         format.json { render json: @post.errors, status: :unprocessable_entity }
       end
     end
   end

  def index
      @post = Post.find(params[:post_id])
      @postvote = @post.postvotes.find(:all, :conditions => {:post_id => @post.id})
  end
end
