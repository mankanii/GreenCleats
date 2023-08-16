import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/authentication/login_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// Methods Start
registerGround(
  name,
  email,
  phone_number,
  ground_name,
  location,
) async {
  var response =
      await http.post(Uri.parse("${url}/registerGroundOwner"), body: {
    "full_name": name,
    "email_address": email,
    "contact_number": phone_number,
    "ground_name": ground_name,
    "location": location,
  });
  return response;
}
// Methods End

class GroundRegistrationPage extends StatefulWidget {
  const GroundRegistrationPage({super.key});

  @override
  State<GroundRegistrationPage> createState() => _GroundRegistrationPageState();
}

class _GroundRegistrationPageState extends State<GroundRegistrationPage> {
  @override
  var name = TextEditingController();
  var email = TextEditingController();
  var phone_number = TextEditingController();
  var ground_name = TextEditingController();
  var location = TextEditingController();

  Widget build(BuildContext context) {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   mainAxisSize: MainAxisSize.max,
    //   children: [
    //     userInputWidget("Name", Icons.person, name),
    //     userInputWidget("Email", Icons.email_rounded, email),
    //     userInputWidget(
    //         "Phone Number", Icons.phone_callback_rounded, phone_number),
    //     userInputWidget(
    //         "Ground Name", Icons.phone_callback_rounded, ground_name),
    //     userInputWidget("Location", Icons.phone_callback_rounded, location),
    //     signUpButton(context),
    //     divider(),
    //   ],
    // );
    return Form(
        child: Container(
            // height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: userInputWidget("Name", Icons.person, name),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: userInputWidget("Email", Icons.email_rounded, email),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: userInputWidget(
              "Phone Number", Icons.phone_callback_rounded, phone_number),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: userInputWidget(
              "Ground Name", Icons.phone_callback_rounded, ground_name),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: userInputWidget(
              "Location", Icons.phone_callback_rounded, location),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: signUpButton(context),
        ),
        // divider(),
        // RichText(
        //   text: TextSpan(
        //       text: 'Already have an account?',
        //       style: TextStyle(color: AppColors.whiteColor, fontSize: 20),
        //       children: <TextSpan>[
        //         TextSpan(
        //             text: ' Log in',
        //             recognizer: TapGestureRecognizer()
        //               ..onTap = () => {
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => const LoginPage()),
        //                     )
        //                   },
        //             style: TextStyle(
        //                 color: AppColors.animationGreenColor, fontSize: 20))
        //       ]),
        // ),
      ],
    )));
    // return Scaffold(
    //   backgroundColor: AppColors.animationGreenColor,
    //   body: Container(
    //     decoration: const BoxDecoration(
    //       image: DecorationImage(
    //         image: NetworkImage("assets/images/stadiumOutline.png"),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: Container(
    //       padding: const EdgeInsets.all(40),
    //       margin: EdgeInsets.only(left: 0, top: 130, right: 0, bottom: 0),
    //       decoration: BoxDecoration(
    //         color: AppColors.animationBlueColor,
    //         borderRadius: const BorderRadius.only(
    //             topLeft: Radius.circular(60.0),
    //             topRight: Radius.circular(60.0)),
    //       ),
    //       // padding: EdgeInsets.symmetric(
    //       //     vertical: MediaQuery.of(context).size.height * 0.05,
    //       //     horizontal: MediaQuery.of(context).size.width * 0.4),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisSize: MainAxisSize.max,
    //         children: [
    //           Container(
    //             child: headerImage(context),
    //           ),
    //           Form(
    //               child: Container(
    //                   // height: MediaQuery.of(context).size.height * 0.7,
    //                   child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             mainAxisSize: MainAxisSize.max,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: userInputWidget("Name", Icons.person, name),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: userInputWidget("Email", Icons.email_rounded, email),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: userInputWidget("Phone Number",
    //                     Icons.phone_callback_rounded, phone_number),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: userInputWidget("Ground Name",
    //                     Icons.phone_callback_rounded, ground_name),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: userInputWidget(
    //                     "Location", Icons.phone_callback_rounded, location),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 30.0),
    //                 child: signUpButton(context),
    //               ),
    //               divider(),
    //               RichText(
    //                 text: TextSpan(
    //                     text: 'Already have an account?',
    //                     style: TextStyle(
    //                         color: AppColors.whiteColor, fontSize: 20),
    //                     children: <TextSpan>[
    //                       TextSpan(
    //                           text: ' Log in',
    //                           recognizer: TapGestureRecognizer()
    //                             ..onTap = () => {
    //                                   Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                         builder: (context) =>
    //                                             const LoginPage()),
    //                                   )
    //                                 },
    //                           style: TextStyle(
    //                               color: AppColors.animationGreenColor,
    //                               fontSize: 20))
    //                     ]),
    //               ),
    //             ],
    //           )))
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget headerImage(BuildContext context) {
    return Image.asset(
      "assets/images/greenGC.png",
      height: 100,
      width: 100,
    );
  }

  Widget userInputWidget(text, icon, myController) {
    return TextFormField(
      style: TextStyle(color: AppColors.whiteColor),
      controller: myController,
      decoration: InputDecoration(
        icon: Icon(icon, color: AppColors.whiteColor),
        labelStyle: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w400),
        labelText: text,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.animationGreenColor),
        ),
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: AppColors.animationGreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () async {
          var response = await registerGround(name.text, email.text,
              phone_number.text, ground_name.text, location.text);

          if (response.statusCode == 200) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${jsonDecode(response.body)['message']}')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${jsonDecode(response.body)['message']}')));
          }
        },
        child: Center(
          child: Text(
            'SIGN UP',
            style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: (Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                const Divider(color: Colors.black, thickness: 1),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                const Text("OR"),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                const Divider(color: Colors.black, thickness: 1),
              ],
            ),
          ),
        ],
      )),
    );
  }

  TextEditingController _date = TextEditingController();
  Widget datePicker(context) {
    return TextField(
      controller: _date,
      style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 20,
          fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        icon: Icon(Icons.calendar_today_rounded, color: AppColors.whiteColor),
        labelText: "Date of birth",
        labelStyle: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.animationGreenColor),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          setState(() {
            _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          });
        }
      },
    );
  }

  Widget passwordInputWidget() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_rounded, color: AppColors.whiteColor),
          labelStyle: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w400),
          labelText: "Password",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.whiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.animationGreenColor),
          ),
        ));
  }
}
