import 'package:flutter/material.dart';
import 'package:green_cleats/apps/PlayersApp/team/team_registration.dart';
import 'package:green_cleats/utils/colors.dart';

class NoTeam extends StatefulWidget {
  var player_id;

  var team_id;

  var player_name;

  NoTeam({
    super.key,
    required this.player_id,
    required this.team_id,
    required this.player_name,
  });

  @override
  State<NoTeam> createState() => _NoTeamState();
}

class _NoTeamState extends State<NoTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("You have not joined any team."),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.animationBlueColor)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeamReg(
                              player_id: widget.player_id,
                              team_id: widget.team_id,
                              player_name: widget.player_name,
                            )),
                  );
                },
                child: Text(
                  "Create your team",
                  style: TextStyle(color: AppColors.whiteColor),
                ))
          ],
        ),
      ),
    );
  }
}
