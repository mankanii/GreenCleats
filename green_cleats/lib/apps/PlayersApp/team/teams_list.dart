import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/team/team_view.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:http/http.dart' as http;

late List teams = [];

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  Future getTeamList() async {
    final response = await http.get(Uri.parse("${url}/teamList"));
    if (response.statusCode == 200) {
      setState(() {
        teams = json.decode(response.body)["teams"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTeamList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
        backgroundColor: AppColors.animationBlueColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/top.jpg',
                  width: double.infinity, height: 250, fit: BoxFit.cover),
              Positioned(
                // The Positioned widget is used to position the text inside the Stack widget
                bottom: 10,
                right: 10,

                child: Container(
                  // We use this Container to create a black box that wraps the white text so that the user can read the text even when the image is white
                  width: 300,
                  color: Colors.black54,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'LIST OF TEAMS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(8.0),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return _buildTeam(context, teams[index]);
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTeam(context, teamData) {
  Map team = teamData;
  // final String sample = images[2];
  return Container(
    color: AppColors.whiteColor,
    child: ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyTeamView(
                    team_id: team["_id"],
                  )),
        );
      },
      leading: CircleAvatar(
        backgroundColor: AppColors.khakiColor,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundImage:
                NetworkImage(team["picture_url"] ?? "assets/images/pic.jpg"),
          ),
        ),
      ),
      title: Text(
        team["team_name"],
        style: TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    ),
  );
}
