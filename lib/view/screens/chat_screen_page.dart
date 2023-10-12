import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/own_card.dart';
import 'package:flutter_application_1/components/reply_card.dart';
import 'package:flutter_application_1/models/MessageModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import '../../components/custom_appbar.dart';
import '../../utils/api_url.dart';
import '../../utils/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatdocScreen extends StatefulWidget {
  final int chat_id;
  final int target_id;
  final token;
  const ChatdocScreen(
      {@required this.token, this.chat_id = 0, this.target_id = 0, Key? key})
      : super(key: key);

  @override
  State<ChatdocScreen> createState() => _ChatdocScreenState();
}

class _ChatdocScreenState extends State<ChatdocScreen> {
  late String email;
  late int id;
  late String name;
  late IO.Socket socket;
  final TextEditingController _messageInputController = TextEditingController();
  final path = ApiUrls.chatpath;
  bool sendButton = false;
  List<MessageModel> messages = [];

  @override
  void initState() {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    name = jwtDecodedToken['name'];
    id = jwtDecodedToken['id'];
    debugPrint("Chat id : ${widget.chat_id}");
    debugPrint("You id : ${id}");
    debugPrint("Target id : ${widget.target_id}");
    connect();
    super.initState();
  }

  void connect() {
    socket = IO.io(path, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.chat_id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message",
          (msg) => {print(msg), setMessage("destination", msg["message"])});
    });
    print(socket.connected);
  }

  void sendMessge(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {'message': message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(message: message, type: type);
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 180,
              decoration: BoxDecoration(color: Colors.amber),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  if (messages[index].type == "source") {
                    return OwenerCard();
                  } else {
                    return ReplyCard();
                  }
                },
                shrinkWrap: true,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5, bottom: 5, right: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[
                            200], // เปลี่ยนสีพื้นหลังของ Container ที่ครอบ Align
                      ),
                      width: MediaQuery.of(context).size.width - 80,
                      child: TextFormField(
                        controller: _messageInputController,
                        onChanged: (value) {
                          if (value.length > 0) {
                            setState(() {
                              sendButton = true;
                            });
                          } else {
                            sendButton = false;
                          }
                        },
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Config.primaryColor,
                    child: IconButton(
                        onPressed: () {
                          if (sendButton) {
                            sendMessge(
                              _messageInputController.text,
                              widget.chat_id,
                              widget.target_id,
                            );
                            _messageInputController.clear();
                          }
                        },
                        icon: Icon(
                          sendButton ? Icons.send : Icons.mic,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
