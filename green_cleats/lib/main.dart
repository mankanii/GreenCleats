import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:green_cleats/apps/GroundOwnerApp/ground_owner_app.dart';
import 'package:green_cleats/apps/GroundOwnerApp/my_ground.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/Pages/camera_layout.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/chat_home.dart';
import 'package:green_cleats/apps/PlayersApp/main_posting_page.dart';
import 'package:green_cleats/apps/PlayersApp/trainerBooking/trainer_history.dart';
import 'package:green_cleats/apps/PlayersApp/player_app.dart';
import 'package:green_cleats/apps/PlayersApp/team/team.dart';
import 'package:green_cleats/apps/TrainerApp/trainers_app.dart';
import 'package:green_cleats/authentication/main_registration_page.dart';
import 'package:green_cleats/nav/bottom_nav.dart';

import 'authentication/login_page.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Green Cleats',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(child: LoginPage()),
        ));
  }
}
