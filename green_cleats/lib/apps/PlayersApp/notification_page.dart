import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/player_app.dart';
import 'package:green_cleats/apps/PlayersApp/team/team_view.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';
import 'package:http/http.dart' as http;

List requests = [];

acceptRequest(own_player_id, teamId) async {
  final response = await http.post(Uri.parse("${url}/requestAccept"), body: {
    "own_player_id": own_player_id,
    "team_id": teamId,
  });
  return response;
}

cancelRequest(own_player_id, sender_player_id, teamId) async {
  final response = await http.post(Uri.parse("${url}/requestReject"), body: {
    "requestToPlayer": own_player_id,
    "teamId": teamId,
    "requestFromPlayer": sender_player_id,
  });
  return response;
}

class NotificationPage extends StatefulWidget {
  var player_id;
  NotificationPage({super.key, required this.player_id});

  @override
  State<NotificationPage> createState() {
    // for (var i = 0; i < notifications.length; i++) {
    //   tempArray.add(notifications[i]["_id"]);
    // }
    // notifications.clear();
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {
  var tempArray = [];

  Future getPlayerRequests() async {
    final response = await http
        .get(Uri.parse("${url}/receivedRequestPlayer/${widget.player_id}"));
    if (response.statusCode == 200) {
      setState(() {
        requests = json.decode(response.body)["data"];
        for (var i = 0; i < requests.length; i++) {
          tempArray.add(requests[i]["_id"]);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlayerRequests();
  }

  @override
  Widget build(BuildContext context) {
    // tempArray.clear();
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: AppColors.animationBlueColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: requests.length == 0
          ? Container(
              child: Center(child: Text("No New Notifications")),
            )
          : Column(
              children: [
                Expanded(
                    child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(8.0),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        return !tempArray.contains(requests[index]["_id"])
                            ? Stack()
                            : Stack(
                                children: <Widget>[
                                  Card(
                                    child: InkWell(
                                      splashColor: AppColors.animationBlueColor,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyTeamView(
                                                    team_id: requests[index]
                                                        ["teamsData"]["_id"],
                                                  )),
                                        );
                                        debugPrint('Card tapped.');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Image.network(
                                              requests[index]["teamsData"]
                                                      ["picture_url"] ??
                                                  owlImage,
                                              width: 100.0,
                                              height: 100.0,
                                            ),
                                            const SizedBox(width: 10.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                "Join My Team",
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .animationBlueColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20.0,
                                                            )),
                                                        const WidgetSpan(
                                                          child: SizedBox(
                                                              width: 25.0),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                                        ),
                                                      ],
                                                    ),
                                                    style: const TextStyle(
                                                        height: 2.0),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        requests[index][
                                                                    "teamsData"]
                                                                ["team_name"] ??
                                                            "",
                                                        // textAlign: TextAlign.justify,
                                                        // overflow: TextOverflow.visible,
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .animationGreenColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                      Text(" - "),
                                                      // Text(
                                                      //   requests[index][
                                                      //               "playersData"]
                                                      //           ["name"] ??
                                                      //       "",
                                                      //   // textAlign: TextAlign.justify,
                                                      //   // overflow: TextOverflow.visible,
                                                      //   style: TextStyle(
                                                      //     color: AppColors
                                                      //         .animationBlueColor,
                                                      //     // fontWeight: FontWeight.bold,
                                                      //     fontSize: 13.0,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 7.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          print("Accepted");
                                                          final response =
                                                              await acceptRequest(
                                                                  widget
                                                                      .player_id,
                                                                  requests[index]
                                                                          [
                                                                          "teamsData"]
                                                                      ["_id"]);
                                                          if (response
                                                                  .statusCode ==
                                                              200) {
                                                            setState(() {
                                                              tempArray.clear();
                                                            });
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PlayerApp(
                                                                            player_id:
                                                                                widget.player_id,
                                                                            index:
                                                                                0,
                                                                          )),
                                                            );
                                                          }
                                                        },
                                                        child: const Text(
                                                            'Accept'),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor: AppColors
                                                              .animationBlueColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12), // <-- Radius
                                                          ),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          print(requests[index]
                                                              ["_id"]);
                                                          await cancelRequest(
                                                              widget.player_id,
                                                              requests[index][
                                                                      "playersData"]
                                                                  ["player_id"],
                                                              requests[index][
                                                                      "teamsData"]
                                                                  ["_id"]);
                                                          setState(() {
                                                            tempArray.remove(
                                                                requests[index]
                                                                    ["_id"]);
                                                          });
                                                          print("Ignored");
                                                        },
                                                        child: const Text(
                                                            'Ignore'),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor: AppColors
                                                              .animationGreenColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12), // <-- Radius
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                        // _buildNotificationItem(
                        //     context, requests[index], () {
                        //   setState(() {});
                        // });
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10.0),
                    ),
                  ],
                ))
              ],
            ),
    );
  }
}
