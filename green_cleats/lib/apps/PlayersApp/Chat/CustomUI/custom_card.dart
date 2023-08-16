import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/Model/chat_model.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/Pages/individual_chat.dart';
import 'package:green_cleats/utils/colors.dart';

class CustomCard extends StatefulWidget {
  var player_id;

  CustomCard({super.key, required this.chatModel, required this.player_id});
  final ChatModel chatModel;
  // final ChatModel sourchat;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IndividualChat(
                chatModel: widget.chatModel,
                player_id: widget.player_id,
              ),
            ));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.animationGreenColor,
                child: SvgPicture.asset(
                  widget.chatModel.icon!,
                  color: AppColors.whiteColor,
                  height: 37,
                  width: 37,
                )),
            title: Text(
              widget.chatModel.name,
              style: TextStyle(
                  color: AppColors.animationGreenColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.done_all,
                  size: 16,
                ),
                SizedBox(
                  width: 3,
                ),
              ],
            ),
            trailing: Text(
              widget.chatModel.time!,
              style: TextStyle(color: AppColors.animationBlueColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
