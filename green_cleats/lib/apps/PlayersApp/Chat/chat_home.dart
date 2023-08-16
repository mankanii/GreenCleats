import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/Model/chat_model.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/Pages/chat_page.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/Pages/select_player.dart';
import 'package:green_cleats/utils/colors.dart';

class ChatHome extends StatefulWidget {
  var player_id;
  ChatHome({super.key, required this.player_id});
  // final List<ChatModel> chatmodels;
  // final ChatModel? sourchat;

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text("Green Chat"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
                ),
                PopupMenuItem(
                  child: Text("New broadcast"),
                  value: "New broadcast",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
            onSelected: (value) {
              print(value);
            },
          ),
        ],
        bottom: TabBar(
            controller: _controller,
            indicatorColor: AppColors.backgroundColor,
            tabs: [
              Tab(
                text: "CHATS",
              ),
              Tab(
                text: "PLAYERS",
              ),
            ]),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          ChatPage(player_id: widget.player_id),
          SelectPlayer(),
        ],
      ),
    );
  }
}
