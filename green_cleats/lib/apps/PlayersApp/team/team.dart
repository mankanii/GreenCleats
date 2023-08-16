import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/team/team_edit.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/widgets/big_text.dart';
import 'package:http/http.dart' as http;

import 'Player.dart';

String? player_id;
String? teamName = "-";
String? description = "-";
String? area = "-";
String? level = "-";
String? type = "-";
String? teamId = "-";
String? founderId = "-";
String? pictureURL = "-";
late List players;
late List requestPlayers = [];

Future getRequestPlayers(player_id) async {
  final response =
      await http.get(Uri.parse("${url}/requestPlayersList/$player_id"));
  if (response.statusCode == 200) {
    requestPlayers = json.decode(response.body)["players"];
    print(requestPlayers.length);
    // requestPlayers.remove(requestPlayers)
  } else {
    throw Exception('Failed to load data');
  }
}

cancelRequest(requestFromID, requestToID) async {
  final response = await http.post(Uri.parse("${url}/requestCancel"), body: {
    "requestFromPlayer": requestFromID,
    "requestToPlayer": requestToID,
  });
  return response;
}

sendRequest(requestToPlayer, requestFromPlayer, teamID) async {
  final response =
      await http.post(Uri.parse("${url}/sendRequestPlayer"), body: {
    "requestToPlayer": requestToPlayer,
    "requestFromPlayer": requestFromPlayer,
    "teamID": teamID,
  });
  return response;
}

Future<List<Player>> getTeamPlayers(id) async {
  final response = await http.get(Uri.parse('${url}/team/$id'));

  if (response.statusCode == 200) {
    // final List<dynamic> result = jsonDecode(response.body)["blogs"];
    final List result = json.decode(response.body)["players"];
    players = json.decode(response.body)["players"];

    return result.map((e) => Player.fromJson(e)).toList();
  } else {
    throw Exception(json.decode(response.body)["message"]);
  }
}

class MyTeam extends StatefulWidget {
  var player_id;

  MyTeam({super.key, required this.player_id});

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  Future getTeam(id) async {
    final response = await http.get(Uri.parse("${url}/team/$id"));
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
    super.initState();
    getTeam(widget.player_id);
    getTeamPlayers(widget.player_id);
    getRequestPlayers(widget.player_id);
  }

  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    player_id = widget.player_id;
    return Scaffold(
      floatingActionButton: Visibility(
          visible: widget.player_id == founderId ? true : false,
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyTeamEdit(
                          teamName: teamName.toString(),
                          description: description.toString(),
                          area: area.toString(),
                          level: level.toString(),
                          pictureURL: pictureURL.toString(),
                          teamId: teamId.toString(),
                          type: type.toString(),
                          player_id: widget.player_id,
                          players: players,
                        )),
              );
            },
            label: const Text('Edit'),
            icon: const Icon(Icons.edit_note),
            backgroundColor: AppColors.animationBlueColor,
          )),
      appBar: AppBar(
        title: Text("My Team"),
        backgroundColor: AppColors.animationBlueColor,
        actions: widget.player_id == founderId
            ? <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    showSearch(context: context, delegate: PlayerSearch());
                  },
                ),
              ]
            : null,
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
                        backgroundImage: NetworkImage("${pictureURL}"),
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
                    Center(
                      child: FutureBuilder<List<Player>>(
                        future: getTeamPlayers(widget.player_id),
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

class PlayerSearch extends SearchDelegate {
  final players_list = requestPlayers;
  final recentPlayers = requestPlayers;
  var tempArray;

  @override
  List<Widget> buildActions(BuildContext context) {
    tempArray = [];
    getRequestPlayers(player_id);
    for (var i = 0; i < players_list.length; i++) {
      if (players_list[i]['playersData'].length != 0) {
        if (players_list[i]['playersData'][0]['requestFromPlayer'] ==
            player_id) {
          tempArray.add(players_list[i]['playersData'][0]['requestToPlayer']);
        }
      }
    }
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              query,
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 64.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentPlayers
        : players_list.where((player) {
            final playerLower = player["name"].toLowerCase();
            final queryLower = query.toLowerCase();

            return playerLower.startsWith(queryLower);
          }).toList();
    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildNoSuggestions() => Center(
        child: Text(
          "No suggestions!",
          style: TextStyle(fontSize: 28.0, color: AppColors.animationBlueColor),
        ),
      );

  Widget buildSuggestionsSuccess(List suggestions) {
    return StatefulBuilder(builder: (BuildContext context, setState) {
      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion["name"].substring(0, query.length);
          final remainingText = suggestion["name"].substring(query.length);
          final ButtonStyle reqStyle = ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
            backgroundColor: AppColors.animationGreenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
          final ButtonStyle sentStyle = ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
            backgroundColor: AppColors.animationBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
          return ListTile(
            onTap: () {
              query = suggestion;

              // # Close search and return result
              //close(context, suggestion)

              // # Navigate to Result Page
              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ResultPage(suggestion),));

              // # Show Results
              showResults(context);
            },
            // leading: Icon(Icons.local_atm),
            // title: Text(suggestion),
            leading: CircleAvatar(
              // radius: 300.0,
              backgroundColor: AppColors.khakiColor,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  // radius: 100.0,
                  backgroundImage: NetworkImage(
                      suggestion["picture_ur"] ?? 'assets/images/pic.jpg'),
                  // backgroundImage: NetworkImage(suggestions[index]["name"] ?? 'assets/images/pic.jpg'),
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: queryText, // Name Shown on Search Field
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    children: [
                      TextSpan(
                        text: remainingText,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                !tempArray.contains(suggestion["player_id"])
                    ? ElevatedButton(
                        style: reqStyle,
                        onPressed: () {
                          sendRequest(
                              suggestion["player_id"], player_id, teamId);
                          setState(() {
                            tempArray.add(suggestion["player_id"]);
                            getRequestPlayers(player_id);
                          });
                          print("Requested");
                        },
                        child: const Text('Request'),
                      )
                    : ElevatedButton(
                        style: sentStyle,
                        onPressed: () {
                          cancelRequest(player_id, suggestion["player_id"]);
                          setState(() {
                            tempArray.remove(suggestion["player_id"]);
                            getRequestPlayers(player_id);
                          });
                          print("Cancelled");
                        },
                        child: const Text("Cancel"),
                      )
              ],
            ),
          );
        },
      );
    });
  }
}

Widget _buildPlayer(context, imageURL, name, player_id) {
  // final String sample = images[2];
  print("$founderId == $player_id");
  return ListTile(
    onTap: () {},
    leading: CircleAvatar(
      backgroundColor: AppColors.khakiColor,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageURL ?? "assets/images/pic.jpg"),
        ),
      ),
    ),
    title: Text(
      founderId == player_id.toString() ? "${name} (Captain)" : "$name",
      style: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    ),
  );
}
