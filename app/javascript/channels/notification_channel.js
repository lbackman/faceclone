import consumer from "./consumer"

consumer.subscriptions.create("Noticed::NotificationChannel", {
  connected() {
    console.log('connected to noticed notification channel')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data)
  }
});
