class CommentsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_blog
  load_and_authorize_resource :only => [:edit, :update, :destroy]
  # GET /comments/new

  def new
    @comment = @blog.comments.new
  end

  # GET /comments/1/edit
  def edit
    @comment = @blog.comments.where(:id => params[:id]).first
  end

  # POST /comments
  def create
    @comment = @blog.comments.new(params[:comment].merge(:user_id => current_user.id))
    @comment.save
    get_all_comments
  end

  # PUT /comments/1
  def update
    @comment = @blog.comments.where(:id => params[:id]).first
    if @comment.update_attributes(params[:comment])
      @message = 'Comment was successfully updated.'
      render :template => "/comments/edit"
    else
      render :template => "/comments/edit"
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = @blog.comments.where(:id => params[:id]).first
    @comment.destroy
    get_all_comments
    render :template => "/comments/create"
  end
end
