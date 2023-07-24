module AvatarsHelper
  def render_user_avatar(user, size, options = {})
    options.merge!(alt: "Avatar for #{user.full_name}", size: size)
    resource = user_avatar(user, size)
    image_tag(resource, options)
  end
  
  private

    def user_avatar(user, size)
      if user.avatar.attached?
        user.avatar.variant(resize_to_limit: [size, nil])
      else
        'avatars/stock_avatar.jpg'
      end
    end
end