import consumer from "./consumer"

consumer.subscriptions.create("Noticed::NotificationChannel", {
  connected() {
    console.log('connected to noticed notification channel')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    this.insertNotification(this.template(data))
    this.incrementNotificationCount()
  },

  insertNotification(link) {
    const noUnreadNotifications = document.querySelector('.no-unread-notifications')
    if (noUnreadNotifications) {
      noUnreadNotifications.remove()
    }
    const notificationDisplay = document.querySelector('.notifications-list.unread')
    notificationDisplay.insertAdjacentHTML('afterbegin', link)
  },

  incrementNotificationCount() {
    const notificationCount = document.querySelector('#notification-count')
    const currentCount = parseInt(notificationCount.innerText)
    if (currentCount < 9) {
      notificationCount.innerText = currentCount + 1
    } else {
      notificationCount.innerText = "9+"
    }
  },

  template(data) {
    return `<li class="dropdown-item"><a href="${data['url']}">${data['message']}</a></li>`
  }
});
