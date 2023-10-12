class Message {
  final String message;
  final String sender;
  final int sender_id;
  final DateTime sentAt;
  Message({
    required this.message,
    required this.sender_id,
    required this.sender,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String,dynamic> message){
    return Message(message: message['message'], sender_id: message['sender_id'], sender: message["sender"], sentAt: DateTime.parse(message['sentAt']));
  }
}
