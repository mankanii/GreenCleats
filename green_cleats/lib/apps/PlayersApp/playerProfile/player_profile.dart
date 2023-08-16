import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/apps/PlayersApp/playerProfile/player_profile_edit.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/widgets/big_text.dart';
import 'package:http/http.dart' as http;

List<String> images = [
  "assets/images/greenGC.png",
  "assets/images/pic.jpg",
  "assets/images/blueGC.png"
];

class PlayerProfile extends StatefulWidget {
  const PlayerProfile({
    super.key,
    required this.id,
    required this.full_name,
    required this.email_address,
    required this.gender,
    required this.contact_number,
    required this.achievements,
    required this.age,
    required this.description,
    required this.experience,
    required this.position,
    required this.team_name,
    required this.pictureURL,
  });

  final String id;
  final String full_name;
  final String email_address;
  final String gender;
  final String contact_number;
  final String achievements;
  final String age;
  final String description;
  final String experience;
  final String position;
  final String team_name;
  final String pictureURL;

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileEditMode(
                      id: widget.id,
                      full_name: widget.full_name,
                      achievements: widget.achievements,
                      age: widget.age,
                      description: widget.description,
                      experience: widget.experience,
                      position: widget.position,
                      pictureURL: widget.pictureURL,
                    )),
          );
        },
        label: const Text('Edit'),
        icon: const Icon(Icons.edit_note),
        backgroundColor: AppColors.animationBlueColor,
      ),
      appBar: AppBar(
        elevation: 20,
        backgroundColor: AppColors.animationBlueColor,
        title: Text("Player Profile"),
      ),
      // appBar: AppBar(
      //   title: Image.asset(
      //     'assets/images/greenGC.png',
      //     fit: BoxFit.cover,
      //     height: 100,
      //     width: 100,
      //   ),
      //   backgroundColor: AppColors.animationBlueColor,
      //   elevation: 20,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.notifications),
      //       tooltip: 'Notifications',
      //       onPressed: () {
      //         ScaffoldMessenger.of(context)
      //             .showSnackBar(const SnackBar(content: Text('Notifications')));
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.chat_rounded),
      //       tooltip: 'Player chat',
      //       onPressed: () {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(content: Text('Private Messaging')));
      //       },
      //     ),
      //     IconButton(
      //       onPressed: () => {
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => PlayerProfile()),
      //         // )
      //       },
      //       padding: EdgeInsets.only(top: 1, bottom: 1, left: 1, right: 4),
      //       icon: CircleAvatar(
      //         radius: 300.0,
      //         backgroundColor: AppColors.khakiColor,
      //         child: Padding(
      //           padding: const EdgeInsets.all(2.0),
      //           child: CircleAvatar(
      //             radius: 100.0,
      //             backgroundImage: NetworkImage(widget.pictureURL),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
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
                        backgroundImage: NetworkImage('${widget.pictureURL}'),
                        radius: 68,
                      ),
                    ),
                    VerticalDivider(
                      width: 20,
                      thickness: 5,
                      // indent: 20,
                      // endIndent: 0,
                      color: AppColors.khakiColor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "${widget.full_name}",
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
                              text: "${widget.position}",
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
                              text: "${widget.age}",
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
                child: Container(
                  width: double.infinity,
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
                          // textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          widget.description,
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
                          widget.achievements,
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
                          widget.experience,
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
                          "${widget.team_name}",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                              color: AppColors.animationBlueColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  ImageDialog(int index) {
    return Dialog(
      child: Container(
        width: 200,
        height: 500,
        decoration: BoxDecoration(
            color: AppColors.blackColor,
            image: DecorationImage(
                image: ExactAssetImage(images[index]), fit: BoxFit.contain)),
      ),
    );
  }
}
