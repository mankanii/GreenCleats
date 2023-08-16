import 'package:flutter/material.dart';
import 'package:green_cleats/apps/TrainerApp/trainer_app_settings.dart';
import 'package:green_cleats/apps/TrainerApp/trainer_booked_history.dart';
import 'package:green_cleats/apps/TrainerApp/trainer_image.dart';
import 'package:green_cleats/apps/TrainerApp/trainer_info.dart';
import 'package:green_cleats/apps/TrainerApp/trainer_packages.dart';
import 'package:green_cleats/authentication/login_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

late String _trainerId;

class TrainerApp extends StatefulWidget {
  var trainerId = "";

  TrainerApp({super.key, required this.trainerId});

  @override
  State<TrainerApp> createState() => _TrainerAppState();
}

class _TrainerAppState extends State<TrainerApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _trainerId = widget.trainerId;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Choice> choices = <Choice>[
      Choice(
          title: 'Trainer Info',
          icon: Icons.info_outline_rounded,
          navi: ProfilePage(
            trainerId: widget.trainerId,
          )),
      Choice(
          title: 'Trainer Image',
          icon: Icons.image_outlined,
          navi: ImagePage(
            trainerId: widget.trainerId,
          )),
      Choice(
          title: 'Packages',
          icon: Icons.pages,
          navi: PackageDetailsPage(
            trainerId: widget.trainerId,
          )),
      Choice(
          title: 'Booking History',
          icon: Icons.history_toggle_off,
          navi: TrainerBookedPage(
            trainerId: widget.trainerId,
          )),
      Choice(
          title: 'Settings',
          icon: Icons.settings_applications_sharp,
          navi: TrainerSettings()),
    ];
    print("Widget Id is ${widget.trainerId}");
    return MaterialApp(
      title: 'Green Cleats - Trainer',
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
                  MaterialPageRoute(builder: (context) => LoginPage()),
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
                              "Train To Improve",
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
