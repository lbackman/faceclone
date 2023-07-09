class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_notifications, if: :current_user

  def after_sign_out_path_for(resource_or_scope)
    unauthenticated_root_path
  end

  def render_access_denied
    render :file => "#{Rails.root}/public/403.html",  :status => 403, layout: false, status: :forbidden
  end

  private

  def set_notifications
    notifications = Notification.where(recipient: current_user).newest_first.limit(9).includes([:recipient])
    @unread = notifications.unread
    @read = notifications.read
  end

  def mark_notifications_as_read(notifications)
    if current_user
      notifications.where(read_at: nil).update_all(read_at: Time.zone.now)
    end
  end
end
