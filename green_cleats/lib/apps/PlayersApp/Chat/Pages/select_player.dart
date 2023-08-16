import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/CustomUI/player_card.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/Model/chat_model.dart';
import 'package:green_cleats/utils/colors.dart';

class SelectPlayer extends StatefulWidget {
  const SelectPlayer({super.key});

  @override
  State<SelectPlayer> createState() => _SelectPlayerState();
}

class _SelectPlayerState extends State<SelectPlayer> {
  List<ChatModel> players = [
    ChatModel(name: "Shayan Ali Mankani"),
    ChatModel(name: "Hallar Khalil"),
    ChatModel(name: "Ahsan"),
    ChatModel(name: "Zeehan"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 20,
        //   title: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "Select Player",
        //         style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        //       ),
        //       Text(
        //         "150 Players",
        //         style: TextStyle(fontSize: 13),
        //       ),
        //     ],
        //   ),
        //   actions: [
        //     IconButton(
        //         onPressed: () {},
        //         icon: Icon(
        //           Icons.search,
        //           size: 26,
        //         ))
        //   ],
        // ),
        body: ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) => PlayerCard(
            player: players[index],
          ),
        ));
  }
}
