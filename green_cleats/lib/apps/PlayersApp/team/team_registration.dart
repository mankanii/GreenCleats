import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/More/more_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:http/http.dart' as http;

const List<String> levelsList = <String>[
  'U15',
  'U20',
  'Ameture Club',
  'Proffetional Club',
  'District',
  'Depart',
];
const List<String> typeList = <String>[
  'Futsal',
  'Fullfield',
  'Both',
];

var teamName = TextEditingController();
var teamDescription = TextEditingController();
var teamArea = TextEditingController();

createTeam(teamName, teamDescription, teamArea, teamLevel, teamType, id) async {
  var response = await http.post(Uri.parse("${url}/registerTeam"), body: {
    "team_name": teamName,
    "description": teamDescription,
    "area": teamArea,
    "level": teamLevel,
    "type": teamType,
    "founder_id": id,
  });

  return response;
}

class TeamReg extends StatefulWidget {
  var player_id;

  var team_id;

  var player_name;

  TeamReg({
    super.key,
    required this.player_id,
    required this.team_id,
    required this.player_name,
  });

  @override
  State<TeamReg> createState() => _TeamRegState();
}

class _TeamRegState extends State<TeamReg> {
  String dropdownlevelValue = levelsList.first;
  String dropdownTypeValue = typeList.last;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Your Team"),
        backgroundColor: AppColors.animationBlueColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Image.asset('assets/images/team.jpg',
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
                    'CREATE YOUR TEAM',
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: teamName,
                      decoration: InputDecoration(
                        labelText: "Team Name",
                        prefixIcon: Icon(Icons.edit_outlined,
                            color: AppColors.animationBlueColor),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: teamDescription,
                      decoration: InputDecoration(
                        labelText: "Description",
                        prefixIcon: Icon(Icons.description_outlined,
                            color: AppColors.animationBlueColor),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: teamArea,
                      decoration: InputDecoration(
                        labelText: "Area",
                        prefixIcon: Icon(Icons.location_searching_rounded,
                            color: AppColors.animationBlueColor),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: dropdownlevelValue,
                          dropdownColor: AppColors.animationGreenColor,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          borderRadius: BorderRadius.circular(10),
                          style: TextStyle(
                              color: AppColors.animationBlueColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          underline: Container(
                            height: 2,
                            color: AppColors.animationBlueColor,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownlevelValue = value!;
                            });
                          },
                          items: levelsList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        DropdownButton<String>(
                          value: dropdownTypeValue,
                          dropdownColor: AppColors.animationGreenColor,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          borderRadius: BorderRadius.circular(10),
                          style: TextStyle(
                              color: AppColors.animationBlueColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          underline: Container(
                            height: 2,
                            color: AppColors.animationBlueColor,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownTypeValue = value!;
                            });
                          },
                          items: typeList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    MaterialButton(
                      height: 50,
                      color: AppColors.animationGreenColor,
                      onPressed: () async {
                        var response = await createTeam(
                            teamName.text,
                            teamDescription.text,
                            teamArea.text,
                            dropdownlevelValue,
                            dropdownTypeValue,
                            widget.player_id);

                        if (response.statusCode == 200) {
                          widget.team_id = jsonDecode(response.body)["teamId"];
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  '${jsonDecode(response.body)['message']}')));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MorePage(
                                      player_id: widget.player_id,
                                      team_id: widget.team_id,
                                      player_name: widget.player_name,
                                    )),
                          );
                          teamName.clear();
                          teamDescription.clear();
                          teamArea.clear();
                          dropdownlevelValue = levelsList.first;
                          dropdownTypeValue = typeList.last;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  '${jsonDecode(response.body)['message']}')));
                        }
                      },
                      child: Text(
                        "Create Team",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              // child: Form(
              //     child: Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         TextFormField(
              //           controller: teamName,
              //           decoration: InputDecoration(
              //             icon: Icon(Icons.edit_outlined,
              //                 color: AppColors.animationBlueColor),
              //             labelStyle: TextStyle(
              //                 color: AppColors.animationBlueColor,
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w400),
              //             labelText: "Team Name",
              //             enabledBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10),
              //               borderSide:
              //                   BorderSide(color: AppColors.animationBlueColor),
              //             ),
              //             focusedBorder: OutlineInputBorder(
              //               borderSide: BorderSide(
              //                   color: AppColors.animationGreenColor),
              //             ),
              //           ),
              //         ),
              //         TextFormField(
              //           controller: teamDescription,
              //           decoration: InputDecoration(
              //             icon: Icon(Icons.description_outlined,
              //                 color: AppColors.animationBlueColor),
              //             labelStyle: TextStyle(
              //                 color: AppColors.animationBlueColor,
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w400),
              //             labelText: "Description",
              //             enabledBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10),
              //               borderSide:
              //                   BorderSide(color: AppColors.animationBlueColor),
              //             ),
              //             focusedBorder: OutlineInputBorder(
              //               borderSide: BorderSide(
              //                   color: AppColors.animationGreenColor),
              //             ),
              //           ),
              //         ),
              //         TextFormField(
              //           controller: teamArea,
              //           decoration: InputDecoration(
              //             icon: Icon(Icons.location_searching_rounded,
              //                 color: AppColors.animationBlueColor),
              //             labelStyle: TextStyle(
              //                 color: AppColors.animationBlueColor,
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w400),
              //             labelText: "Area",
              //             enabledBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10),
              //               borderSide:
              //                   BorderSide(color: AppColors.animationBlueColor),
              //             ),
              //             focusedBorder: OutlineInputBorder(
              //               borderSide: BorderSide(
              //                   color: AppColors.animationGreenColor),
              //             ),
              //           ),
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             Text("level"),
              //             DropdownButton<String>(
              //               value: dropdownlevelValue,
              //               dropdownColor: AppColors.animationGreenColor,
              //               icon: const Icon(Icons.arrow_downward),
              //               elevation: 16,
              //               borderRadius: BorderRadius.circular(10),
              //               style: TextStyle(
              //                   color: AppColors.animationBlueColor,
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w400),
              //               underline: Container(
              //                 height: 2,
              //                 color: AppColors.animationBlueColor,
              //               ),
              //               onChanged: (String? value) {
              //                 // This is called when the user selects an item.
              //                 setState(() {
              //                   dropdownlevelValue = value!;
              //                 });
              //               },
              //               items: levelsList
              //                   .map<DropdownMenuItem<String>>((String value) {
              //                 return DropdownMenuItem<String>(
              //                   value: value,
              //                   child: Text(value),
              //                 );
              //               }).toList(),
              //             ),
              //             Text("type"),
              //             DropdownButton<String>(
              //               value: dropdownTypeValue,
              //               dropdownColor: AppColors.animationGreenColor,
              //               icon: const Icon(Icons.arrow_downward),
              //               elevation: 16,
              //               borderRadius: BorderRadius.circular(10),
              //               style: TextStyle(
              //                   color: AppColors.animationBlueColor,
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w400),
              //               underline: Container(
              //                 height: 2,
              //                 color: AppColors.animationBlueColor,
              //               ),
              //               onChanged: (String? value) {
              //                 // This is called when the user selects an item.
              //                 setState(() {
              //                   dropdownTypeValue = value!;
              //                 });
              //               },
              //               items: typeList
              //                   .map<DropdownMenuItem<String>>((String value) {
              //                 return DropdownMenuItem<String>(
              //                   value: value,
              //                   child: Text(value),
              //                 );
              //               }).toList(),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     MaterialButton(
              //       height: 50,
              //       color: AppColors.animationGreenColor,
              //       onPressed: () async {
              //         var response = await createTeam(
              //             teamName.text,
              //             teamDescription.text,
              //             teamArea.text,
              //             dropdownlevelValue,
              //             dropdownTypeValue,
              //             widget.player_id);

              //         if (response.statusCode == 200) {
              //           widget.team_id = jsonDecode(response.body)["teamId"];
              //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //               content: Text(
              //                   '${jsonDecode(response.body)['message']}')));
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => MorePage(
              //                       player_id: widget.player_id,
              //                       team_id: widget.team_id,
              //                       player_name: widget.player_name,
              //                     )),
              //           );
              //           teamName.clear();
              //           teamDescription.clear();
              //           teamArea.clear();
              //           dropdownlevelValue = levelsList.first;
              //           dropdownTypeValue = typeList.last;
              //         } else {
              //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //               content: Text(
              //                   '${jsonDecode(response.body)['message']}')));
              //         }
              //       },
              //       child: Center(
              //         child: Text(
              //           'Create',
              //           style: TextStyle(
              //               color: AppColors.whiteColor,
              //               fontSize: 20,
              //               fontWeight: FontWeight.w400),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ),
              //   ],
              // )),
            ),
          )
        ],
      ),
    );
  }
}
