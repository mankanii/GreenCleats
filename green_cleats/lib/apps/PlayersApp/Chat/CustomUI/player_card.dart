import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/Model/chat_model.dart';
import 'package:green_cleats/utils/colors.dart';

class PlayerCard extends StatefulWidget {
  const PlayerCard({super.key, required this.player});
  final ChatModel player;

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: SvgPicture.network(
            "assets/person.svg",
            color: AppColors.whiteColor,
            height: 30,
            width: 30,
          ),
          backgroundColor: AppColors.animationBlueColor,
        ),
        title: Text(
          widget.player.name,
          style: TextStyle(
              color: AppColors.animationBlueColor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
