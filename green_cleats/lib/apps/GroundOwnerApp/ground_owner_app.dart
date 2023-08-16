import 'package:flutter/material.dart';
import 'package:green_cleats/apps/GroundOwnerApp/ground_booked_history.dart';
import 'package:green_cleats/apps/GroundOwnerApp/ground_images.dart';
import 'package:green_cleats/apps/GroundOwnerApp/ground_info.dart';
import 'package:green_cleats/apps/GroundOwnerApp/ground_settings.dart';
import 'package:green_cleats/apps/GroundOwnerApp/uploaded_slots.dart';
import 'package:green_cleats/authentication/login_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'my_ground.dart';

var ground_id;

class GroundOwnerApp extends StatefulWidget {
  var groundID;

  GroundOwnerApp({super.key, required this.groundID});

  @override
  State<GroundOwnerApp> createState() {
    ground_id = groundID;
    return _GroundOwnerAppState();
  }
}

class _GroundOwnerAppState extends State<GroundOwnerApp> {
  @override
  Widget build(BuildContext context) {
    List<Choice> choices = <Choice>[
      Choice(
          title: 'Ground Info',
          icon: Icons.stadium_outlined,
          navi: GroundInfo(
            groundID: widget.groundID,
          )),
      Choice(
          title: 'Add Slots',
          icon: Icons.add_box_outlined,
          navi: MyGround(
            groundID: widget.groundID,
          )),
      Choice(
          title: 'Uploaded Slots',
          icon: Icons.file_upload_outlined,
          navi: UploadedSlots(
            groundID: widget.groundID,
          )),
      Choice(
          title: 'Ground Images',
          icon: Icons.image_outlined,
          navi: GroundImages(
            groundID: widget.groundID,
          )),
      Choice(
          title: 'Booking History',
          icon: Icons.history_toggle_off,
          navi: GroundBookedPage(
            groundId: widget.groundID,
          )),
      Choice(
          title: 'Password',
          icon: Icons.password_outlined,
          navi: GroundSettings(
            groundId: widget.groundID,
          )),
    ];
    return MaterialApp(
      title: 'Green Cleats - Ground Owner',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/greenGC.png',
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          backgroundColor: AppColors.animationBlueColor,
          elevation: 20,
          actions: [
            MaterialButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                )
              },
              color: AppColors.animationGreenColor,
              child: Center(
                  child: Text(
                "Log Out",
                style: TextStyle(color: AppColors.whiteColor),
              )),
            )
          ],
        ),
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          children: [
            Container(
              height: 220,
              child: Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xff3F5069),
                          Color.fromARGB(255, 99, 125, 165),
                          Color.fromARGB(255, 141, 178, 233),
                        ],
                      )),
                    ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GradientText(
                              "GREEN CLEATS",
                              style: TextStyle(
                                  fontSize: 28.0, fontWeight: FontWeight.bold),
                              colors: [
                                Color(0xff3F5069),
                                Color.fromARGB(255, 99, 125, 165),
                                Color.fromARGB(255, 141, 178, 233),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 8.0,
                      children: List.generate(choices.length, (index) {
                        return Center(
                          child: SelectCard(choice: choices[index]),
                        );
                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon, required this.navi});
  final String title;
  final IconData icon;
  final navi;
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => choice.navi),
        );
      },
      child: Card(
          color: AppColors.backgroundColor,
          elevation: 20,
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Icon(
                    color: AppColors.animationBlueColor,
                    choice.icon,
                    size: 50.0,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      choice.title,
                      style: TextStyle(
                          color: AppColors.animationBlueColor, fontSize: 12),
                    ),
                  ),
                ]),
          )),
    );
  }
}
