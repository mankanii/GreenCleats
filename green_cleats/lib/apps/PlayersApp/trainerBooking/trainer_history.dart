import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/player_app.dart';
import 'package:green_cleats/apps/PlayersApp/trainerBooking/trainer_page.dart';
import 'package:green_cleats/nav/bottom_nav.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';

class BookedTrainerPage extends StatefulWidget {
  final String player_id;

  BookedTrainerPage({
    Key? key,
    required this.player_id,
  }) : super(key: key);

  @override
  _BookedTrainerPageState createState() => _BookedTrainerPageState();
}

class _BookedTrainerPageState extends State<BookedTrainerPage> {
  // Mock data for the booked trainer
  String trainerName = "";
  String trainerType = "";
  String packageType = "";
  String dateBooked = "";
  String trainerImage = "";
  final int daysLeft = 15;
  String subscriptionStatus = "";
  bool isTrainerBooked = false;

  void cancelSubscription() {}

  @override
  void initState() {
    super.initState();
    trainerHired(widget.player_id).then((response) {
      if (response.statusCode == 200) {
        print("${json.decode(response.body)['booking']}");
        setState(() {
          isTrainerBooked = true;
          trainerName =
              json.decode(response.body)["booking"][0]["trainer_name"];
          trainerType =
              json.decode(response.body)["booking"][0]["trainer_type"];
          packageType =
              json.decode(response.body)["booking"][0]["package_type"];
          dateBooked = json.decode(response.body)["booking"][0]["booking_date"];
          subscriptionStatus =
              json.decode(response.body)["booking"][0]["subscription_status"];
          trainerImage = json.decode(response.body)["booking"][0]["image"];

          print("Trainer name is $trainerName");
        });
      } else {
        isTrainerBooked = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${json.decode(response.body)['message']}"),
          duration: const Duration(seconds: 2),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isTrainerBooked) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text("My Trainer"),
          backgroundColor: AppColors.animationBlueColor,
        ),
        body: Stack(
          children: [
            Image.asset(
              trainerLocalImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.6),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You need a trainer?",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor),
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.whiteColor)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerApp(
                                  player_id: widget.player_id, index: 3),
                            ));
                      },
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                            color: AppColors.animationBlueColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      var trainerImageUrl;
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text("My Trainer"),
          backgroundColor: AppColors.animationBlueColor,
        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              child: Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: trainerImage.isNotEmpty
                        ? Image.network(
                            trainerImage,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            trainerLocalImage,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  Positioned(
                    top: 70,
                    right: 25,
                    left: 25,
                    child: SizedBox(
                      height: 140,
                      width: 300,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey, //New
                                blurRadius: 25.0,
                                offset: Offset(0, -10))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Subscription Status:",
                                  style: TextStyle(
                                      color: AppColors.animationBlueColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  subscriptionStatus,
                                  style: TextStyle(
                                      color: AppColors.animationGreenColor,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            if (subscriptionStatus == "Active")
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Days Left:",
                                    style: TextStyle(
                                      color: AppColors.animationBlueColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "$daysLeft days",
                                    style: TextStyle(
                                        color: AppColors.redColor,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 0.0,
                                  top: 8.0,
                                  right: 12.0,
                                  left: 12.0),
                              child: SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppColors.animationBlueColor),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Cancel Subscription"),
                                            content: Text(
                                                "Are you sure you want to cancel?"),
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .animationBlueColor),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .animationBlueColor),
                                                ),
                                                onPressed: () {
                                                  cancelSubscription();
                                                  debugPrint(
                                                      'Subscription cancelled.');
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text("Cancel Subscription")),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: Image.network(
                              trainerImage.isNotEmpty
                                  ? trainerImage
                                  : trainerLocalImage,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              trainerImage.isNotEmpty
                                  ? trainerImage
                                  : trainerLocalImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        height: 200.0,
                        width: double.infinity,
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Center(
                            child: Text(
                              'Tap to view image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Trainer Name:",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.animationBlueColor,
                      ),
                    ),
                    Text(
                      trainerName,
                      style: TextStyle(color: AppColors.animationBlueColor),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "Trainer Type:",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.animationBlueColor,
                      ),
                    ),
                    Text(
                      trainerType,
                      style: TextStyle(color: AppColors.animationBlueColor),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "Package Type:",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.animationBlueColor,
                      ),
                    ),
                    Text(
                      packageType,
                      style: TextStyle(color: AppColors.animationBlueColor),
                    ),
                    // SizedBox(height: 16.0),
                    // Text(
                    //   "Time Slot:",
                    //   style: TextStyle(
                    //     fontSize: 16.0,
                    //     fontWeight: FontWeight.bold,
                    //     color: AppColors.animationBlueColor,
                    //   ),
                    // ),
                    // Text(
                    //   timeSlot,
                    //   style: TextStyle(color: AppColors.animationBlueColor),
                    // ),
                    SizedBox(height: 16.0),
                    Text(
                      "Date Booked:",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.animationBlueColor,
                      ),
                    ),
                    Text(
                      dateBooked,
                      style: TextStyle(color: AppColors.animationBlueColor),
                    ),
                    SizedBox(height: 32.0),
                  ],
                )),
          ],
        ),
      );
    }
  }
}
