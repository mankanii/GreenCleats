import 'package:flutter/material.dart';
import 'package:green_cleats/apps/PlayersApp/More/Events/events_page.dart';
import 'package:green_cleats/apps/PlayersApp/More/about_us.dart';
import 'package:green_cleats/apps/PlayersApp/More/change_password.dart';
import 'package:green_cleats/apps/PlayersApp/team/no_team.dart';
import 'package:green_cleats/apps/PlayersApp/team/team.dart';
import 'package:green_cleats/apps/PlayersApp/team/team_registration.dart';
import 'package:green_cleats/apps/PlayersApp/team/teams_list.dart';
import 'package:green_cleats/authentication/login_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../groundBooking/booking_history.dart';
import '../trainerBooking/trainer_history.dart';
import 'contact_us.dart';

// class MorePage extends StatefulWidget {
//   var player_id;

//   var team_id;

//   MorePage({super.key, required this.player_id, required this.team_id});

//   @override
//   State<MorePage> createState() => _MorePageState();
// }

// class _MorePageState extends State<MorePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               children: [
//                 //Log Out
//                 SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                       colors: <Color>[
//                         Color(0xff3F5069),
//                         Color.fromARGB(255, 99, 125, 165),
//                         Color.fromARGB(255, 141, 178, 233),
//                       ],
//                     )),
//                     child: TextButton(
//                       style: ButtonStyle(
//                         foregroundColor: MaterialStateProperty.all<Color>(
//                             AppColors.whiteColor),
//                         // textStyle: (),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Log Out",
//                             style: TextStyle(
//                                 fontSize: 20.0, fontWeight: FontWeight.bold),
//                           ),
//                           Icon(
//                             Icons.logout_rounded,
//                             size: 30,
//                             color: AppColors.whiteColor,
//                           )
//                         ],
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => LoginPage()),
//                         );
//                         // Navigator.of(context)
//                         //     .popUntil((route) => route.isFirst);
//                       },
//                     ),
//                   ),
//                 ),
//                 Divider(
//                   thickness: 1.0,
//                   color: AppColors.animationGreenColor.withOpacity(0.4),
//                   height: 32.0,
//                 ),
//                 // Features
//                 textButtonF("Teams", Team()),
//                 textButtonF(
//                     "My Team",
//                     widget.team_id == "none"
//                         ? NoTeam(
//                             player_id: player_id,
//                             team_id: widget.team_id,
//                           )
//                         : MyTeam(
//                             player_id: widget.player_id,
//                           )),
//                 textButtonF(
//                     "Create Your Team",
//                     widget.team_id == "none"
//                         ? TeamReg(
//                             player_id: widget.player_id,
//                             team_id: widget.team_id,
//                           )
//                         : MyTeam(
//                             player_id: widget.player_id,
//                           )),
//                 Divider(
//                   thickness: 1.0,
//                   color: AppColors.animationGreenColor.withOpacity(0.4),
//                   height: 32.0,
//                 ),
//                 textButtonF("Booking History", BookingHistory()),
//                 Divider(
//                   thickness: 1.0,
//                   color: AppColors.animationGreenColor.withOpacity(0.4),
//                   height: 32.0,
//                 ),
//                 textButtonF("Events", EventsPage()),
//                 Divider(
//                   thickness: 1.0,
//                   color: AppColors.animationGreenColor.withOpacity(0.4),
//                   height: 32.0,
//                 ),
//                 textButtonF2("Change Password"),
//                 textButtonF2("About Us"),
//                 textButtonF2("Contact Us"),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   SizedBox textButtonF2(String textName) {
//     return SizedBox(
//       height: 40,
//       width: double.infinity,
//       child: Container(
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//           colors: <Color>[
//             Color.fromARGB(255, 141, 178, 233),
//             Color.fromARGB(255, 99, 125, 165),
//             Color(0xff3F5069),
//           ],
//         )),
//         child: TextButton(
//           style: ButtonStyle(
//             foregroundColor:
//                 MaterialStateProperty.all<Color>(AppColors.whiteColor),
//             // textStyle: (),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 textName,
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               Icon(
//                 Icons.arrow_right_alt_rounded,
//                 size: 30,
//                 color: AppColors.whiteColor,
//               )
//             ],
//           ),
//           onPressed: () {},
//         ),
//       ),
//     );
//   }

//   SizedBox textButtonF(String textName, Widget need) {
//     return SizedBox(
//       height: 40,
//       width: double.infinity,
//       child: Container(
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//           colors: <Color>[
//             Color.fromARGB(255, 141, 178, 233),
//             Color.fromARGB(255, 99, 125, 165),
//             Color(0xff3F5069),
//           ],
//         )),
//         child: TextButton(
//           style: ButtonStyle(
//             foregroundColor:
//                 MaterialStateProperty.all<Color>(AppColors.whiteColor),
//             // textStyle: (),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 textName,
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               Icon(
//                 Icons.arrow_right_alt_rounded,
//                 size: 30,
//                 color: AppColors.whiteColor,
//               )
//             ],
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => need),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class MorePage extends StatefulWidget {
  var player_id;
  var team_id;

  var player_name;

  MorePage({
    super.key,
    required this.player_id,
    required this.team_id,
    required this.player_name,
  });

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    print("Name: ${widget.player_name}");
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
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
                            "${widget.player_name}",
                            style: TextStyle(
                                fontSize: 28.0, fontWeight: FontWeight.bold),
                            colors: [
                              Color(0xff3F5069),
                              Color.fromARGB(255, 99, 125, 165),
                              Color.fromARGB(255, 141, 178, 233),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 0.0, top: 8.0, right: 12.0, left: 12.0),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  },
                                  child: Text("Log Out")),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              children: [
                // navButton("Log Out", Icons.logout_rounded, () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => LoginPage()),
                //   );
                // }),
                navButton("Teams", Icons.border_all, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Team()),
                  );
                }),
                navButton("My Team", Icons.people_alt_rounded, () {
                  if (widget.team_id == "none") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoTeam(
                                player_id: widget.player_id,
                                team_id: widget.team_id,
                                player_name: widget.player_name,
                              )),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyTeam(
                                player_id: widget.player_id,
                              )),
                    );
                  }
                }),
                navButton("Create Your Team", Icons.app_registration, () {
                  if (widget.team_id == "none") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TeamReg(
                                player_id: widget.player_id,
                                team_id: widget.team_id,
                                player_name: widget.player_name,
                              )),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyTeam(
                                player_id: widget.player_id,
                              )),
                    );
                  }
                }),
                navButton("Booking History", Icons.history, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingHistory(
                              teamId: widget.team_id,
                            )),
                  );
                }),
                navButton("My Trainer", Icons.fitness_center_outlined, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookedTrainerPage(
                              player_id: widget.player_id,
                            )),
                  );
                }),
                navButton("Events", Icons.event, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventsPage()),
                  );
                }),
                navButton("Change Password", Icons.password_rounded, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordPage()),
                  );
                }),
                navButton("About Us", Icons.info_outline, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                }),
                navButton("Contact Us", Icons.contact_phone_rounded, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactUsPage()),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector navButton(String text, IconData icon, onTap) {
    return GestureDetector(
      onTap: onTap,
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
                    icon,
                    size: 50.0,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: TextStyle(
                          color: AppColors.animationBlueColor, fontSize: 12),
                    ),
                  ),
                ]),
          )),
    );
  }
}
