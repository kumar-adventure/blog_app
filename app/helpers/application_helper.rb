module ApplicationHelper

  def like_dislike_image_url(blog)
    if current_user
      fist_bump =  blog.fist_bumps.where(:user_id => current_user.id).first
      return (fist_bump.present? && fist_bump.is_like) ? "/assets/unlike.png" : "/assets/like.png"
    end   
    "/assets/like.png"
  end
  
  def custom_visible(blog)
    return 'custom_visible' if blog.user == current_user
  end

  def get_user_thumb_image(user)
    if user.avatar?
      image_tag(user.avatar_url(:thumb))
    else
      image_tag("user_icon.jpg")
    end
  end

end
