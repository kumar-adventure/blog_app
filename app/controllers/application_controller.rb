class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private
  def get_blog
    params[:blog_id] ||= params[:id]
    @blog = Blog.where(:id => params[:blog_id]).first
    redirect_to root_path, notice: "Blog not found." if @blog.blank?
  end

  def get_all_comments
    @comments = @blog.comments.reload
  end

end
