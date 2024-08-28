import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  received(data) {
    // Handle the incoming notification, e.g., prepend it to a list or update a badge count
    $("#notifications").prepend(data.notification);
    // Optionally play a sound or show a toast
  }
});
