import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/CustomUI/own_message_card.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/CustomUI/reply_card.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/Pages/camera_layout.dart';
import 'package:green_cleats/utils/colors.dart';
import '../Model/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualChat extends StatefulWidget {
  var player_id;

  IndividualChat({
    super.key,
    required this.chatModel,
    required this.player_id,
  });
  final ChatModel chatModel;
  // final ChatModel sourchat;

  @override
  State<IndividualChat> createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  FocusNode focusNode = FocusNode();

  List messages = [];

  late IO.Socket socket;

  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMessages(widget.player_id, widget.chatModel.id).then((response) {
      var _messages = response["messages"];
      for (var message in _messages) {
        print(message);
        setState(() {
          messages.add({
            "sender_id": message["sender_id"],
            "receiver_id": message["receiver_id"],
            "message_content": message["message_content"],
            "date": message["date"]
          });
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", "widget.sourchat.id");
    socket.onConnect((data) => print("Connected"));
    print(socket.connected);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/chatback.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: AppColors.animationBlueColor,
            leadingWidth: 70,
            titleSpacing: 2,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  CircleAvatar(
                    child: SvgPicture.asset(
                      widget.chatModel.icon!,
                      width: 36,
                      height: 36,
                      color: AppColors.whiteColor,
                    ),
                    radius: 20,
                    backgroundColor: AppColors.animationGreenColor,
                  ),
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  widget.chatModel.name,
                  style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("View Profile"),
                      value: "View Profile",
                    ),
                    PopupMenuItem(
                      child: Text("Media"),
                      value: "Media",
                    ),
                    PopupMenuItem(
                      child: Text("Search"),
                      value: "Search",
                    ),
                  ];
                },
                onSelected: (value) {
                  print(value);
                },
              ),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                // Container(
                //   height: MediaQuery.of(context).size.height - 110,
                //   child: ListView(
                //     shrinkWrap: true,
                //     children: [
                //       OwnMessageCard(),
                //       ReplyCard(),
                //       OwnMessageCard(),
                //       ReplyCard(),
                //       OwnMessageCard(),
                //       ReplyCard(),
                //       OwnMessageCard(),
                //       ReplyCard(),
                //       OwnMessageCard(),
                //       ReplyCard(),
                //       OwnMessageCard(),
                //       ReplyCard(),
                //       OwnMessageCard(),
                //       ReplyCard(),
                //       OwnMessageCard(),
                //       ReplyCard(),
                //       OwnMessageCard(),
                //       ReplyCard(),
                //     ],
                //   ),
                // ),
                Container(
                  height: MediaQuery.of(context).size.height - 110,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Build your custom card widgets here based on the values in yourList
                      return messages[index]["sender_id"] == widget.player_id
                          ? OwnMessageCard(
                              message: messages[index]["message_content"],
                              date: messages[index]["date"])
                          : ReplyCard(
                              message: messages[index]["message_content"],
                              date: messages[index]["date"]);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Card(
                              margin:
                                  EdgeInsets.only(left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextFormField(
                                controller: _controller,
                                focusNode: focusNode,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message",
                                  prefixIcon: IconButton(
                                    color: AppColors.animationBlueColor,
                                    icon: Icon(Icons.sports_soccer),
                                    onPressed: () {
                                      // focusNode.unfocus();
                                      // focusNode.canRequestFocus = false;
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(5),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          color: AppColors.animationBlueColor,
                                          onPressed: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) =>
                                                  bottomSheet(),
                                            );
                                          },
                                          icon: Icon(Icons.attach_file)),
                                      IconButton(
                                          color: AppColors.animationBlueColor,
                                          onPressed: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           CameraLayout(),
                                            //     ));
                                          },
                                          icon: Icon(Icons.camera_alt)),
                                    ],
                                  ),
                                ),
                              ))),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, right: 5, left: 2),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.animationBlueColor,
                          child: IconButton(
                              icon:
                                  Icon(Icons.send, color: AppColors.whiteColor),
                              onPressed: () {
                                print("Pressed: ${_controller.text}");
                                sendMessage(widget.player_id,
                                        widget.chatModel.id, _controller.text)
                                    .then((value) {
                                  setState(() {
                                    messages.add({
                                      "sender_id": widget.player_id,
                                      "receiver_id": widget.chatModel.id,
                                      "message_content": _controller.text,
                                      "date":
                                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                                    });
                                  });
                                  _controller.clear();
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: AppColors.backgroundColor,
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconCreation(Icons.insert_drive_file,
                  AppColors.animationGreenColor, "Document"),
              SizedBox(
                width: 40,
              ),
              iconCreation(
                  Icons.camera_alt, AppColors.animationGreenColor, "Camera"),
              SizedBox(
                width: 40,
              ),
              iconCreation(
                  Icons.insert_photo, AppColors.animationGreenColor, "Gallery"),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: AppColors.whiteColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
