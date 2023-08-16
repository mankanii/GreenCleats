import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../player_app.dart';

XFile? pickedFile;

updateProfile(full_name, achievements, age, description, experience, position,
    id, image) async {
  String imageData = "";
  if (image != null) {
    imageData = await convertToBase64(image);
  }
  var response = await http.post(Uri.parse("${url}/playerProfile/$id"), body: {
    "full_name": full_name,
    "position": position,
    "age": age,
    "description": description,
    "achievements": achievements,
    "experience": experience,
    "picture": imageData,
  });
  return response;
}

class ProfileEditMode extends StatefulWidget {
  var full_name;

  var achievements;

  var age;

  var description;

  var experience;

  var position;

  var id;

  var pictureURL;

  ProfileEditMode({
    super.key,
    required this.id,
    required this.full_name,
    required this.position,
    required this.age,
    required this.description,
    required this.achievements,
    required this.experience,
    required this.pictureURL,
  });

  @override
  State<ProfileEditMode> createState() => _ProfileEditModeState();
}

class _ProfileEditModeState extends State<ProfileEditMode> {
  String? _imageFile = "";
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var full_name_controller = TextEditingController(text: widget.full_name);
    var achievements_controller =
        TextEditingController(text: widget.achievements);
    var age_controller = TextEditingController(text: widget.age);
    var description_controller =
        TextEditingController(text: widget.description);
    var experience_controller = TextEditingController(text: widget.experience);
    var position_controller = TextEditingController(text: widget.position);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("Edit Profile",
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
                          backgroundImage: NetworkImage('${widget.pictureURL}'),
                          radius: 68,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: AppColors.khakiColor,
                        radius: 70,
                        child: CircleAvatar(
                          child: Image.asset(_imageFile!),
                          // backgroundImage: AssetImage(_imageFile!),
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
          buildTextField("Full Name*", "", full_name_controller),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: buildTextField("Position*", "", position_controller)),
              SizedBox(
                width: 10,
              ),
              Expanded(child: buildTextField("Age*", "", age_controller)),
            ],
          ),
          buildTextField("Description", "", description_controller),
          buildTextField("Achievements", "", achievements_controller),
          buildTextField("Experience", "", experience_controller),
          // editModeText("Ratings"),
          // const RatingBarWidget(),
          // editModeText("Current Teams"),
          // editModeText("Images"),
          // const AddImage(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {} catch (e) {}
          var response = await updateProfile(
              full_name_controller.text,
              achievements_controller.text,
              age_controller.text,
              description_controller.text,
              experience_controller.text,
              position_controller.text,
              widget.id,
              pickedFile);
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('--->${jsonDecode(response.body)['message']}')));
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayerApp(
                        player_id: widget.id,
                        index: 0,
                      )),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('--->${jsonDecode(response.body)['message']}')));
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

  Padding editModeText(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
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
}
