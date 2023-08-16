import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import 'ground_owner_app.dart';

class GroundImages extends StatefulWidget {
  var groundID;

  GroundImages({super.key, required this.groundID});

  @override
  State<GroundImages> createState() => _GroundImagesState();
}

class _GroundImagesState extends State<GroundImages> {
  var _totalImages = [];
  List<XFile> _selectedImagesToUpload = [];
  List _selectedImagesBase64 = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectImage() async {
    final List<XFile>? result = await _picker.pickMultiImage(imageQuality: 50);
    if (result!.length + _totalImages.length <= groundImagesLimit) {
      if (result != null) {
        setState(() {
          _selectedImagesToUpload.addAll(result);
          _totalImages.addAll(result);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You can not add more than 4 Images'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _totalImages.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGroundsImages(widget.groundID).then((images) {
      setState(() {
        _totalImages.addAll(images);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text(
          "Ground Images",
          style: TextStyle(
              color: AppColors.whiteColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              _selectedImagesBase64.clear();
              for (var element in _selectedImagesToUpload) {
                _selectedImagesBase64.add(await convertToBase64(element));
              }
              if (_selectedImagesBase64.isNotEmpty) {
                var response = await uploadGroundImages(
                    widget.groundID, _selectedImagesBase64);
                if (response.statusCode == 200) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroundOwnerApp(
                              groundID: widget.groundID,
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
                      builder: (context) => GroundOwnerApp(
                            groundID: widget.groundID,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Images:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.animationBlueColor),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.animationBlueColor)),
                  onPressed: _selectImage,
                  child: Text('Select Image'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: _totalImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.network(
                        _totalImages[index].runtimeType == XFile
                            ? _totalImages[index].path
                            : _totalImages[index]["picture_url"],
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        "Are you sure you want to delete this image?"),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color:
                                                  AppColors.animationBlueColor),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .all<Color>(AppColors
                                                        .animationBlueColor)),
                                        child: Text(
                                          "Sure",
                                          style: TextStyle(
                                              color: AppColors.whiteColor),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          if (_totalImages[index].runtimeType !=
                                              XFile) {
                                            await deleteGroundsImage(
                                                _totalImages[index]["_id"],
                                                _totalImages[index]
                                                    ["public_id"]);
                                          }
                                          _deleteImage(index);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 12,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
