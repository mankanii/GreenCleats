import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/playerProfile/player_profile_view.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/widgets/big_text.dart';
import 'package:http/http.dart' as http;

import 'Player.dart';

String? teamName = "loading";
String? description = "loading";
String? area = "loading";
String? level = "loading";
String? type = "loading";
String? teamId = "loading";
String? founderId = "loading";
String? pictureURL = "loading";

Future<List<Player>> getTeamPlayers(team_id) async {
  final response = await http.get(Uri.parse('${url}/fetchPlayers/$team_id'));

  if (response.statusCode == 200) {
    final List result = json.decode(response.body)["players"];

    return result.map((e) => Player.fromJson(e)).toList();
  } else {
    throw Exception(json.decode(response.body)["message"]);
  }
}

class MyTeamView extends StatefulWidget {
  var team_id;

  MyTeamView({super.key, required this.team_id});

  @override
  State<MyTeamView> createState() => _MyTeamViewState();
}

class _MyTeamViewState extends State<MyTeamView> {
  Future getTeam(team_id) async {
    final response = await http.get(Uri.parse("${url}/fetchTeam/$team_id"));
    print("===> ${json.decode(response.body)["team"]}");
    if (response.statusCode == 200) {
      setState(() {
        var teamData = json.decode(response.body)["team"];
        teamName = teamData["team_name"];
        description = teamData["description"];
        area = teamData["area"];
        level = teamData["level"];
        type = teamData["type"];
        teamId = teamData["_id"];
        pictureURL = teamData["picture_url"] ?? "assets/images/pic.jpg";
        founderId = teamData["founder_id"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeam(widget.team_id);
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
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.khakiColor,
                          radius: 70,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                pictureURL ?? 'assets/images/pic.jpg'),
                            radius: 68,
                          ),
                        ),
                      ],
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
                          text: "${teamName}",
                          size: 22,
                          color: AppColors.animationGreenColor,
                        ),
                        RichText(
                            text: TextSpan(
                          text: "Level: ",
                          style: TextStyle(
                              color: AppColors.animationGreenColor,
                              fontSize: 16,
                              fontStyle: FontStyle.italic),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${level}",
                              style: TextStyle(
                                  color: AppColors.animationBlueColor,
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal),
                            ),
                          ],
                        )),
                        RichText(
                            text: TextSpan(
                          text: "Type: ",
                          style: TextStyle(
                              color: AppColors.animationGreenColor,
                              fontSize: 16,
                              fontStyle: FontStyle.italic),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${type}",
                              style: TextStyle(
                                  color: AppColors.animationBlueColor,
                                  fontSize: 18,
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
                        // textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "${description}",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationBlueColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Area",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationGreenColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "${area}",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationBlueColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Players",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: AppColors.animationGreenColor),
                      ),
                    ),
                    FutureBuilder<List<Player>>(
                      future: getTeamPlayers(widget.team_id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            padding: const EdgeInsets.all(8.0),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return _buildPlayer(
                                context,
                                snapshot.data![index].pictureURL,
                                snapshot.data![index].playerName,
                                snapshot.data![index].playerId,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10.0),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
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

Widget _buildPlayer(context, imageURL, name, player_id) {
  // final String sample = images[2];
  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlayerProfileView(player_id: player_id)),
      );
    },
    leading: CircleAvatar(
      backgroundColor: AppColors.khakiColor,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageURL ?? "assets/images/pic.jpg"),
        ),
      ),
    ),
    title: Text(
      "$name",
      style: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    ),
  );
}
