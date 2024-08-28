class NotificationService
  def self.notify_user(user, content, type = 'general')
    if user.act?
      Notification.create!(user: user, content: content, read: false, notification_type: type)
    end
  end

  def self.notify_user(user, content, type = 'general')
    if user.act?
      notification = Notification.create!(user: user, content: content, read: false, notification_type: type)
      NotificationChannel.broadcast_to(user, notification: render_notification(notification))
    end
  end

  def self.render_notification(notification)
    ApplicationController.renderer.render(partial: 'notifications/notification', locals: { notification: notification })
  end
end
