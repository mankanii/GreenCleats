import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/authentication/login_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/widgets/gender_widget.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

const List<String> list = <String>[
  'Football Coach',
  'Physical Trainer',
  'Gym Trainer',
  'Other'
];

class TrainerRegistrationPage extends StatefulWidget {
  const TrainerRegistrationPage({super.key});

  @override
  State<TrainerRegistrationPage> createState() =>
      _TrainerRegistrationPageState();
}

class _TrainerRegistrationPageState extends State<TrainerRegistrationPage> {
  @override
  var _name = TextEditingController();
  var _email = TextEditingController();
  var _phone_number = TextEditingController();
  var _date = TextEditingController();
  String _dropdownValue = list.first;
  var _gender;
  @override
  Widget build(BuildContext context) {
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
          child: userInputWidget("Name", Icons.person, _name),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: userInputWidget("Email", Icons.email_rounded, _email),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: userInputWidget(
              "Phone Number", Icons.phone_callback_rounded, _phone_number),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: datePicker(context),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: expertiseDropDown()),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: GenderWidget(),
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
        //             recognizer: new TapGestureRecognizer()
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
    //       margin: const EdgeInsets.only(left: 0, top: 130, right: 0, bottom: 0),
    //       decoration: BoxDecoration(
    //         color: AppColors.animationBlueColor,
    //         borderRadius: const BorderRadius.only(
    //             topLeft: Radius.circular(60.0),
    //             topRight: Radius.circular(60.0)),
    //       ),
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
    //                 child: userInputWidget("Name", Icons.person, _name),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child:
    //                     userInputWidget("Email", Icons.email_rounded, _email),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: userInputWidget("Phone Number",
    //                     Icons.phone_callback_rounded, _phone_number),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: datePicker(context),
    //               ),
    //               Padding(
    //                   padding: const EdgeInsets.only(top: 8.0),
    //                   child: expertiseDropDown()),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: GenderWidget(),
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
    //                           recognizer: new TapGestureRecognizer()
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

  Widget headerImage(BuildContext _context) {
    return Container(
      child: Image.asset(
        "assets/images/greenGC.png",
        height: 100,
        width: 100,
      ),
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
          print("Clicked on Trainer Sign Up");
          var response = await registerTrainer(_name.text, _email.text,
              _phone_number.text, _date.text, _dropdownValue, _gender);

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
      margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
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
            firstDate: DateTime(1950),
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

  Widget expertiseDropDown() {
    return DropdownButton<String>(
      value: _dropdownValue,
      dropdownColor: AppColors.animationGreenColor,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      borderRadius: BorderRadius.circular(10),
      style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 20,
          fontWeight: FontWeight.w400),
      underline: Container(
        height: 2,
        color: AppColors.whiteColor,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          _dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  List<String> genders = ["Male", "Female", "Other"];
  List<bool> isSelected = [true, false, false];

  Widget GenderWidget() {
    _gender = genders[0];
    return ToggleButtons(
      isSelected: isSelected,
      borderRadius: BorderRadius.circular(10),
      color: AppColors.whiteColor,
      fillColor: AppColors.animationGreenColor,
      selectedColor: AppColors.whiteColor,
      splashColor: AppColors.animationGreenColor,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Male"),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Female"),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Other"),
        ),
      ],
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < isSelected.length; index++) {
            if (index == newIndex) {
              isSelected[index] = true;
              _gender = genders[index];
              print("Gender is $_gender");
            } else {
              isSelected[index] = false;
            }
          }
        });
      },
    );
  }
}
