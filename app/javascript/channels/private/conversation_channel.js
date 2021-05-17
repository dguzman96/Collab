import consumer from "./consumer"

consumer.subscriptions.create("Private::ConversationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
});

def send_message(data)
  message_params = data['message'].each_with_object({}) do |el, hash|
    hash[el['name']] = el['value']
  end
  Private::Message.create(message_params)
end
