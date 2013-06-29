class BlogsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show]
  before_filter :get_blog, :except => [:index, :new, :create]
  before_filter :get_all_comments, :only => [:show]  
  before_filter :blog_like, :only => [:like_unlike, :like_unlike_on_comment]

  load_and_authorize_resource :only => [:edit, :update, :destroy]
  
  # GET /blogs
  def index
    @blogs = current_user.blogs.order("updated_at DESC").page params[:page]
  end

  # GET /blogs/1
  def show
    @comment = Comment.new
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  def create
    @blog = current_user.blogs.new(params[:blog])
    if @blog.save
      redirect_to blogs_path, notice: 'Blog was successfully created.' 
    else
      render action: "new" 
    end
  end

  # PUT /blogs/1
  def update
    if @blog.update_attributes(params[:blog])
      redirect_to edit_blog_path(@blog), notice: 'Blog was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  # DELETE /blogs/1
  def destroy
    flash[:notice] = "blog deleted successfully." if @blog.destroy
    redirect_to blogs_path 
  end

  def publish
    flash[:notice] = if @blog.update_attributes(:publish_at => Time.now, :is_published => true)
      "Blog was publish successfully."   
    else
      "Blog not published successfully."   
    end  
    redirect_to blogs_path
  end

  def like_unlike
    redirect_to "/users/#{@blog.user.id}/profile"
  end

  def like_unlike_on_comment
    redirect_to blog_path(@blog.id)
  end

  private
  def blog_like
    unless @blog.user == current_user
      fist = @blog.fist_bumps.find_or_create_by_user_id(:user_id => current_user.id) 
      fist.update_attribute(:is_like, !fist.is_like)
      flash[:notice] = fist.is_like? ? "Thanks for like." : "You have unlike."
    else
      flash[:notice] = "You did not like successfully."
    end
  end

end
