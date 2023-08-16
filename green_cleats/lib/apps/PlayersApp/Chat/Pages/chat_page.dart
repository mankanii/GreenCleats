import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/CustomUI/custom_card.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/Model/chat_model.dart';
import 'package:green_cleats/utils/colors.dart';

class ChatPage extends StatefulWidget {
  var player_id;

  ChatPage({
    super.key,
    required this.player_id,
  });
  // final List<ChatModel> chatmodels;
  // final ChatModel sourchat;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    // ChatModel(
    //   name: "Mankani",
    //   icon: "person.svg",
    // ),
    // ChatModel(
    //   name: "Aadesh",
    //   icon: "person.svg",
    // ),
    // ChatModel(
    //   name: "Shayan",
    //   icon: "person.svg",
    // ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final Set<String> uniqueIds = {};
    getMessagedPlayers(widget.player_id).then((response) {
      var players = response["players"];

      for (final player in players) {
        var _player = player["players"];
        final id = _player[0]['player_id'].toString();
        if (!uniqueIds.contains(id)) {
          uniqueIds.add(id);

          setState(() {
            chats.add(
              ChatModel(
                  name: _player[0]['name'],
                  id: _player[0]['player_id'],
                  icon: 'person.svg',
                  time: player["date"]),
            );
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: AppColors.animationBlueColor,
      //   child: Icon(
      //     Icons.chat,
      //   ),
      // ),
      body: ListView.builder(
          itemCount: chats.length,
          // itemCount: widget.chatmodels.length,
          itemBuilder: (context, index) => CustomCard(
                chatModel: chats[index],
                player_id: widget.player_id,

                // sourchat: widget.sourchat,
              )),
    );
  }
}
