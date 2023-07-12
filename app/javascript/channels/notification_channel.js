import consumer from "./consumer"

consumer.subscriptions.create("Noticed::NotificationChannel", {
  connected() {
    console.log('connected to noticed notification channel')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    this.incrementNotificationCount()
  },

  incrementNotificationCount() {
    const notificationCount = document.querySelector('#notification-count')
    const currentCount = parseInt(notificationCount.innerText)
    if (currentCount < 9) {
      notificationCount.innerText = currentCount + 1
    } else {
      notificationCount.innerText = "9+"
    }
  }
});
