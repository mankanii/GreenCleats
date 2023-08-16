import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/player_app.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

XFile? pickedFile;

const List<String> _levelsList = <String>[
  'U15',
  'U20',
  'Ameture Club',
  'Proffetional Club',
  'District',
  'Depart',
];
const List<String> _typeList = <String>[
  'Futsal',
  'Fullfield',
  'Both',
];
String? _dropdownLevelValue;
String? _dropdownTypeValue;

class MyTeamEdit extends StatefulWidget {
  const MyTeamEdit(
      {super.key,
      required this.teamName,
      required this.description,
      required this.area,
      required this.level,
      required this.type,
      required this.teamId,
      required this.pictureURL,
      required this.player_id,
      required this.players});

  final String teamName;
  final String description;
  final String area;
  final String level;
  final String type;
  final String teamId;
  final String pictureURL;
  final String player_id;
  final List players;

  @override
  State<MyTeamEdit> createState() {
    _dropdownLevelValue = level;
    _dropdownTypeValue = type;
    return _MyTeamEditState();
  }
}

updateTeam(teamName, description, area, level, type, image, team_id) async {
  Uint8List base64Data;
  String imageData = "";
  if (image != null) {
    base64Data = await image!.readAsBytes();
    imageData = base64.encode(base64Data);
  }
  var response =
      await http.post(Uri.parse("${url}/updateTeam/$team_id"), body: {
    "teamName": teamName,
    "description": description,
    "area": area,
    "level": level,
    "type": type,
    "picture": imageData,
  });

  return response;
}

class _MyTeamEditState extends State<MyTeamEdit> {
  String? _imageFile = "";
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var teamName = TextEditingController(text: widget.teamName);
    var description = TextEditingController(text: widget.description);
    var area = TextEditingController(text: widget.area);
    var pictureURL = TextEditingController(text: widget.pictureURL);
    // print("Data Type: ${widget.players}");
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("Edit Team",
            style: TextStyle(color: AppColors.animationBlueColor)),
        backgroundColor: AppColors.animationGreenColor,
        leading: GestureDetector(
          child: Icon(
            Icons.close_rounded,
            color: AppColors.animationBlueColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(padding: EdgeInsets.all(12.0), children: [
          Center(
            child: Stack(
              children: [
                _imageFile == ""
                    ? CircleAvatar(
                        backgroundColor: AppColors.khakiColor,
                        radius: 70,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("${widget.pictureURL}"),
                          radius: 68,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: AppColors.khakiColor,
                        radius: 70,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(_imageFile!),
                          radius: 68,
                        ),
                      ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 4, color: AppColors.backgroundColor),
                          color: AppColors.animationBlueColor),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottonSheet()));
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ))
              ],
            ),
          ),
          buildTextField("Team Name*", "", teamName),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Level*",
                    style: TextStyle(
                        color: AppColors.animationBlueColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  dropDown(),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Type*",
                    style: TextStyle(
                        color: AppColors.animationBlueColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  dropDown2(),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          buildTextField("Description", "", description),
          buildTextField("Area", "", area),
          // buildTextField("Experience", ""),
          editModeText("Players"),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(8.0),
            itemCount: widget.players.length,
            itemBuilder: (context, index) {
              return _buildPlayer(context, widget.players[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          ),
          // const RatingBarWidget(),
          // editModeText("Current Teams"),
          // editModeText("Images"),
          // const AddImage(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("Clicked on save");
          var response = await updateTeam(
              teamName.text,
              description.text,
              area.text,
              _dropdownLevelValue,
              _dropdownTypeValue,
              pickedFile,
              widget.teamId);
          if (response.statusCode == 200) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayerApp(player_id: widget.player_id,index: 0,)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${jsonDecode(response.body)['message']}')));
          }
        },
        tooltip: 'Save',
        backgroundColor: AppColors.animationGreenColor,
        child: const Text("Save"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.animationGreenColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 90),
              child: IconButton(
                icon: Icon(
                  Icons.people,
                  color: AppColors.animationGreenColor,
                ),
                onPressed: () {
                  //Nothing is to be done here
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  DropdownButton<String> dropDown() {
    return DropdownButton<String>(
      value: _dropdownLevelValue,
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
        // This is called when the user selects an item.
        setState(() {
          _dropdownLevelValue = value!;
        });
      },
      items: _levelsList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  DropdownButton<String> dropDown2() {
    return DropdownButton<String>(
      value: _dropdownTypeValue,
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
        // This is called when the user selects an item.
        setState(() {
          _dropdownTypeValue = value!;
        });
      },
      items: _typeList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget bottonSheet() {
    return Container(
      height: 100.0,
      width: 20.0,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            // Column(
            //   children: [
            //     IconButton(
            //       icon: Icon(Icons.camera),
            //       onPressed: () {
            //         takephto(ImageSource.camera);
            //       },
            //     ),
            //     Text("Camera"),
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    takephto(ImageSource.gallery);
                  },
                ),
                Text("Gallery"),
              ],
            ),
          ]),
        ],
      ),
    );
  }

  void takephto(ImageSource source) async {
    pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!.path;
    });
  }

  Padding editModeText(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.animationBlueColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding buildTextField(
      String labelText, String placeholder, TextEditingController value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: value,
        style: TextStyle(color: AppColors.animationBlueColor),
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.animationGreenColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.animationBlueColor)),
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.animationBlueColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            color: AppColors.animationBlueColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

Widget _buildPlayer(context, playerData) {
  Map player = playerData;
  // final String sample = images[2];
  return ListTile(
    onTap: () {},
    leading: CircleAvatar(
      backgroundColor: AppColors.khakiColor,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: CircleAvatar(
  backgroundImage: player["picture_url"] != null
      ? NetworkImage(player["picture_url"] as String)
      : AssetImage("assets/images/pic.jpg") as ImageProvider<Object>,
)
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          player["name"],
          style: TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        IconButton(
            onPressed: () {
              // if () {

              // } else {

              // }
            },
            icon: Icon(Icons.clear)),
      ],
    ),
  );
}
