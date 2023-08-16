import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/TrainerApp/trainers_app.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

var _pickedFile;
String imagePublicId = "";

class ImagePage extends StatefulWidget {
  var trainerId;

  ImagePage({super.key, required this.trainerId});
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  String? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    _pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (_pickedFile != null) {
        _imageFile = _pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this image?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  _imageFile = null;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    trainerData(widget.trainerId).then((response) {
      var trainer = json.decode(response.body)["trainer"];
      setState(() {
        trainer["public_id"] == null
            ? null // Sending null if public id is found null
            : imagePublicId = trainer["public_id"];
        _imageFile = trainer["picture_url"];
        print("Image File = $_imageFile and public id = $imagePublicId");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text('Trainer Image'),
        elevation: 20,
        actions: [
          MaterialButton(
            onPressed: () async {
              // Save profile changes
              if (_pickedFile != null) {
                var image = await convertToBase64(_pickedFile);
                var response = await uploadTrainerImage(
                    widget.trainerId, image, imagePublicId);
                if (response.statusCode == 200) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrainerApp(
                              trainerId: widget.trainerId,
                            )),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${json.decode(response.body)['message']}"),
                    duration: const Duration(seconds: 2),
                  ));
                }
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrainerApp(
                            trainerId: widget.trainerId,
                          )),
                );
              }
            },
            color: AppColors.animationGreenColor,
            child: Center(
                child: Text(
              "Save",
              style: TextStyle(color: AppColors.whiteColor),
            )),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile == null
                ? Text('No image selected.')
                : Image(
                    image: NetworkImage(_imageFile!),
                    height: 300,
                    width: 300,
                  ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ElevatedButton(
                //   style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all(
                //           AppColors.animationBlueColor)),
                //   child: Text('Take a Picture'),
                //   onPressed: () {
                //     _getImage(ImageSource.camera);
                //   },
                // ),
                // SizedBox(width: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppColors.animationBlueColor)),
                  child: Text('Choose from Gallery'),
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // _imageFile == null
            //     ? SizedBox()
            //     : ElevatedButton(
            //         style: ButtonStyle(
            //             backgroundColor: MaterialStateProperty.all(
            //                 AppColors.animationBlueColor)),
            //         child: Text('Delete'),
            //         onPressed: () {
            //           _showDeleteConfirmationDialog();
            //         },
            //       ),
          ],
        ),
      ),
    );
  }
}
