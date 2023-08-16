import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/widgets/big_text.dart';
import 'package:http/http.dart' as http;

var team_name = "";
var full_name = "";
var achievements = "";
var age = "";
var description = "";
var experience = "";
var position = "";
var pictureURL = "";
var teamId = "";

class PlayerProfileView extends StatefulWidget {
  var player_id;

  PlayerProfileView({super.key, required this.player_id});

  @override
  State<PlayerProfileView> createState() => _PlayerProfileViewState();
}

class _PlayerProfileViewState extends State<PlayerProfileView> {
  Future fetchData(id) async {
    final response = await http.get(Uri.parse("${url}/playerProfile/$id"));
    if (response.statusCode == 200) {
      setState(() {
        Map playerData = json.decode(response.body)["player"];
        team_name = json.decode(response.body)["team_name"] ?? "No Team";
        full_name = playerData["name"] ?? "name";
        achievements = playerData["achievements"] ?? "achievement";
        age = playerData["age"] ?? "age";
        description = playerData["description"] ?? "description";
        experience = playerData["experience"] ?? "experience";
        position = playerData["position"] ?? "position";
        pictureURL = playerData["picture_url"] ?? "assets/images/pic.jpg";
        teamId = playerData["team_id"] ?? "team_id";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(widget.player_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, left: 10, right: 10, bottom: 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.khakiColor,
                      radius: 70,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(pictureURL),
                        radius: 68,
                      ),
                    ),
                    VerticalDivider(
                      width: 20,
                      thickness: 5,
                      color: AppColors.khakiColor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: full_name,
                          size: 22,
                          color: AppColors.animationGreenColor,
                        ),
                        RichText(
                            text: TextSpan(
                          text: "Position: ",
                          style: TextStyle(
                              color: AppColors.animationGreenColor,
                              fontSize: 22,
                              fontStyle: FontStyle.italic),
                          children: <TextSpan>[
                            TextSpan(
                              text: position,
                              style: TextStyle(
                                  color: AppColors.animationBlueColor,
                                  fontSize: 22,
                                  fontStyle: FontStyle.normal),
                            ),
                          ],
                        )),
                        RichText(
                            text: TextSpan(
                          text: "Age: ",
                          style: TextStyle(
                              color: AppColors.animationGreenColor,
                              fontSize: 22,
                              fontStyle: FontStyle.italic),
                          children: <TextSpan>[
                            TextSpan(
                              text: age,
                              style: TextStyle(
                                  color: AppColors.animationBlueColor,
                                  fontSize: 22,
                                  fontStyle: FontStyle.normal),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 18.0, left: 12.0, right: 12.0, bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationGreenColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        description,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationBlueColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Achievements",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationGreenColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        achievements,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationBlueColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Experience",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationGreenColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        experience,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationBlueColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Current Team",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationGreenColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        team_name,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationBlueColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
