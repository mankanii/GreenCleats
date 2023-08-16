import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/groundBooking/ground_checkout.dart';
import 'package:green_cleats/apps/PlayersApp/playerProfile/player_profile.dart';
import 'package:green_cleats/utils/utils.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';

bool slotSelected = false;

class GroundPage extends StatefulWidget {
  var groundData;

  var groundID;

  var player_id;

  var player_name;

  var team_id;

  GroundPage(
      {Key? key,
      required this.groundData,
      required this.player_id,
      required this.player_name,
      required this.team_id})
      : super(key: key);

  @override
  _GroundPageState createState() => _GroundPageState();
}

class _GroundPageState extends State<GroundPage> {
  DateTime _selectedDate = DateTime.now();
  var _selectedTimeSlot;
  var groundImages;
  List _timeSlots = [];
  // List<String> _timeSlots = [
  //   '10:00 AM - 11:00 AM',
  //   '11:00 AM - 12:00 PM',
  //   '1:00 PM - 2:00 PM',
  //   '2:00 PM - 3:00 PM',
  //   '3:00 PM - 4:00 PM',
  //   '4:00 PM - 5:00 PM',
  // ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.animationGreenColor,
              onPrimary: Colors.white,
              surface: AppColors.backgroundColor,
              onSurface: AppColors.animationGreenColor,
            ),
            dialogBackgroundColor: AppColors.animationBlueColor,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildTimeSlots() {
    if (_timeSlots.length == 0) {
      return Container(
        child: const Text("Slots Not Found On Selected Date"),
        height: 100,
        alignment: Alignment.center,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _timeSlots.map((timeSlot) {
          return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.all(5),
              // width: 80,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.animationGreenColor),
              child: Row(
                children: [
                  Radio(
                    fillColor: MaterialStateProperty.all<Color>(
                        AppColors.animationBlueColor),
                    value: timeSlot,
                    // "12-21",
                    groupValue: _selectedTimeSlot,
                    onChanged: (value) {
                      setState(() {
                        _selectedTimeSlot = value;
                        slotSelected = true;
                      });
                    },
                  ),
                  Text(
                    "${timeSlot['start_time'].toString()} - ${timeSlot['end_time'].toString()}",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ));
        }).toList(),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.groundData["data"].length > 0
        ? groundImages = widget.groundData["data"]
        : groundImages = [
            {"picture_url": owlImage}
          ];
    print("Images: ${groundImages}");
    getSlots(widget.groundData["ground_id"],
            DateFormat('yyyy-MM-dd').format(_selectedDate).toString())
        .then((response) {
      // print("Here From Future ${json.decode(response.body)['slots'][0]['bs']}");
      setState(() {
        _timeSlots = json.decode(response.body)['slots'][0]['bs'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200.0,
              width: double.infinity,
              child: Carousel(
                dotSize: 6.0,
                dotSpacing: 15.0,
                autoplay: false,
                images: [
                  for (var img in groundImages)
                    Image.network(
                      img["picture_url"] ?? owlImage,
                      fit: BoxFit.cover,
                    ),

                  // Image.network(
                  //   "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  //   fit: BoxFit.cover,
                  // ),
                  // Image.network(
                  //   "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  //   fit: BoxFit.cover,
                  // ),
                  // Image.network(
                  //   "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  //   fit: BoxFit.cover,
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.groundData['ground_name']}",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: AppColors.animationGreenColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: AppColors.animationBlueColor.withOpacity(0.08),
                    height: 32.0,
                  ),
                  Text(
                    'Date: ${DateFormat("dd-MM-yyyy").format(_selectedDate).toString()}',
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: 160,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.animationGreenColor)),
                        child: const Text('Select a date'),
                        onPressed: () async {
                          await _selectDate(context);
                          getSlots(
                                  widget.groundData["ground_id"],
                                  DateFormat('yyyy-MM-dd')
                                      .format(_selectedDate)
                                      .toString())
                              .then((response) {
                            setState(() {
                              _timeSlots =
                                  json.decode(response.body)['slots'][0]['bs'];
                            });
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Divider(
                    thickness: 1.0,
                    color: AppColors.animationBlueColor.withOpacity(0.08),
                    height: 32.0,
                  ),
                  const Text(
                    'Time Slot:',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  _buildTimeSlots(),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Column(
                children: [
                  Divider(
                    thickness: 1.0,
                    color: AppColors.animationBlueColor.withOpacity(0.08),
                    height: 32.0,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    widget.groundData['ground_description'] ?? "-",
                    style: TextStyle(
                        fontSize: 16.0, color: AppColors.animationBlueColor),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: AppColors.animationBlueColor.withOpacity(0.08),
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          widget.groundData['location'] ?? "-",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
      ),
      floatingActionButton: SizedBox(
        width: 250,
        child: FloatingActionButton.extended(
          onPressed: () async {
            if (slotSelected) {
              var response = await checkSlot(_selectedTimeSlot["_id"]);
              if (response.statusCode == 200) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GroundCheckout(
                            groundData: widget.groundData,
                            slotSelected: _selectedTimeSlot,
                            player_id: widget.player_id,
                            player_name: widget.player_name,
                            team_id: widget.team_id,
                          )),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${json.decode(response.body)['message']}"),
                  duration: const Duration(seconds: 2),
                ));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please Select Any Slot'),
                duration: Duration(seconds: 2),
              ));
            }
          },
          backgroundColor: AppColors.animationGreenColor,
          label: const Text("Book"),
          icon: const Icon(Icons.book),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
