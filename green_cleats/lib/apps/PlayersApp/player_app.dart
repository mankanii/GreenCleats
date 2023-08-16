import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/chat_home.dart';
import 'package:green_cleats/apps/PlayersApp/notification_page.dart';
import 'package:green_cleats/apps/PlayersApp/team/team.dart';
import '../../nav/bottom_nav.dart';
import 'playerProfile/player_profile.dart';
import '../../utils/colors.dart';
import 'package:http/http.dart' as http;

String? full_name;
String? email_address;
String? gender;
String? contact_number;
String? achievements;
String? age;
String? description;
String? experience;
String? position;
String? team_name;
String? teamId;
String? pictureURL;

// Get Player Data

class PlayerApp extends StatefulWidget {
  final String player_id;

  var index;

  PlayerApp({super.key, required this.player_id, required this.index});

  @override
  State<PlayerApp> createState() {
    return _PlayerAppState();
  }
}

class _PlayerAppState extends State<PlayerApp> {
  Future fetchData(id) async {
    final response = await http.get(Uri.parse("${url}/playerProfile/$id"));
    if (response.statusCode == 200) {
      setState(() {
        Map playerData = json.decode(response.body)["player"];
        team_name = json.decode(response.body)["team_name"] ?? "No Team";
        full_name = playerData["name"] ?? "";
        achievements = playerData["achievements"] ?? "";
        age = playerData["age"] ?? "";
        description = playerData["description"] ?? "";
        experience = playerData["experience"] ?? "";
        position = playerData["position"] ?? "";
        pictureURL = playerData["picture_url"] ?? "assets/images/pic.jpg";
        teamId = playerData["team_id"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.player_id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Cleats',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/greenGC.png',
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          backgroundColor: AppColors.animationBlueColor,
          elevation: 20,
          actions: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: VerticalDivider(
                thickness: sqrt2,
                color: Colors.blueGrey,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: 'Notifications',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationPage(
                            player_id: widget.player_id,
                          )),
                );
              },
            ),
            // const VerticalDivider(),
            IconButton(
              icon: const Icon(Icons.chat_rounded),
              tooltip: 'Player chat',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChatHome(player_id: widget.player_id)),
                );
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(const SnackBar(content: Text('Chat')));
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: VerticalDivider(
                thickness: sqrt2,
                color: Colors.blueGrey,
              ),
            ),
            IconButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlayerProfile(
                            id: widget.player_id,
                            full_name: full_name.toString(),
                            email_address: email_address.toString(),
                            contact_number: contact_number.toString(),
                            description: description.toString(),
                            achievements: achievements.toString(),
                            age: age.toString(),
                            experience: experience.toString(),
                            gender: gender.toString(),
                            team_name: team_name.toString(),
                            position: position.toString(),
                            pictureURL: pictureURL.toString(),
                          )),
                )
              },
              padding:
                  const EdgeInsets.only(top: 1, bottom: 1, left: 1, right: 4),
              icon: CircleAvatar(
                radius: 300.0,
                backgroundColor: AppColors.khakiColor,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(pictureURL.toString()),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BottomNavBar(
            player_id: widget.player_id,
            team_id: teamId,
            player_name: full_name,
            index: widget.index),
      ),
    );
  }
}
