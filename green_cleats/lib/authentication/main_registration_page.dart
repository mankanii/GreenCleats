import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/authentication/ground_registration_page.dart';
import 'package:green_cleats/authentication/login_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

registerPlayer(
  name,
  email_address,
  password,
  contact_number,
  date_of_birth,
  gender,
) async {
  var response = await http.post(Uri.parse("${url}/registerPlayer"), body: {
    "name": name,
    "email_address": email_address,
    "password": password,
    "contact_number": contact_number,
    "date_of_birth": date_of_birth,
    "gender": gender,
  });
  return response;
}

class MainRegistration extends StatefulWidget {
  const MainRegistration({super.key});

  @override
  State<MainRegistration> createState() => _MainRegistrationState();
}

class _MainRegistrationState extends State<MainRegistration> {
  final name = TextEditingController();
  final emailAddress = TextEditingController();
  final password = TextEditingController();
  final contactNumber = TextEditingController();
  final dateOfBirth = TextEditingController();
  List<bool> isSelected = [true, false, false];
  List<String> genders = ["Male", "Female", "Other"];
  String? gender = "Male";

  bool _isHidden = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validate() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void updateStatus() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
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
              child:
                  emailInputWidget("Email", Icons.email_rounded, emailAddress),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: passwordInputWidget(password),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: contactNumberInputWidget(
                  "Phone Number", Icons.phone_callback_rounded, contactNumber),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: datePicker(context),
            ),
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
            //       text: 'Are you a trainer?',
            //       style: TextStyle(
            //           color: AppColors.whiteColor, fontSize: 20),
            //       children: <TextSpan>[
            //         TextSpan(
            //             text: ' Register',
            //             style: TextStyle(
            //                 color: AppColors.animationGreenColor,
            //                 fontSize: 20))
            //       ]),
            // ),
            // RichText(
            //   text: TextSpan(
            //       text: 'You have a ground?',
            //       style: TextStyle(
            //           color: AppColors.whiteColor, fontSize: 20),
            //       children: <TextSpan>[
            //         TextSpan(
            //             text: ' Register',
            //             style: TextStyle(
            //                 color: AppColors.animationGreenColor,
            //                 fontSize: 20))
            //       ]),
            // ),
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
            //                           builder: (context) => LoginPage()),
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
    //   body: SingleChildScrollView(
    //     child: Container(
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: NetworkImage("assets/images/stadiumOutline.png"),
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       child: Container(
    //         padding: const EdgeInsets.all(40),
    //         margin: new EdgeInsets.only(left: 0, top: 130, right: 0, bottom: 0),
    //         decoration: BoxDecoration(
    //           color: AppColors.animationBlueColor,
    //           borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(60.0),
    //               topRight: Radius.circular(60.0)),
    //         ),
    //         // padding: EdgeInsets.symmetric(
    //         //     vertical: MediaQuery.of(context).size.height * 0.05,
    //         //     horizontal: MediaQuery.of(context).size.width * 0.4),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             Container(
    //               child: headerImage(context),
    //             ),
    //             Form(
    //                 key: _formKey,
    //                 autovalidateMode: AutovalidateMode.onUserInteraction,
    //                 child: Container(
    //                     // height: MediaQuery.of(context).size.height * 0.7,
    //                     child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   mainAxisSize: MainAxisSize.max,
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 8.0),
    //                       child: userInputWidget("Name", Icons.person, name),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 8.0),
    //                       child: emailInputWidget(
    //                           "Email", Icons.email_rounded, emailAddress),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 8.0),
    //                       child: passwordInputWidget(password),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 8.0),
    //                       child: contactNumberInputWidget("Phone Number",
    //                           Icons.phone_callback_rounded, contactNumber),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 8.0),
    //                       child: datePicker(context),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 8.0),
    //                       child: GenderWidget(),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 30.0),
    //                       child: signUpButton(context),
    //                     ),
    //                     divider(),
    //                     // RichText(
    //                     //   text: TextSpan(
    //                     //       text: 'Are you a trainer?',
    //                     //       style: TextStyle(
    //                     //           color: AppColors.whiteColor, fontSize: 20),
    //                     //       children: <TextSpan>[
    //                     //         TextSpan(
    //                     //             text: ' Register',
    //                     //             style: TextStyle(
    //                     //                 color: AppColors.animationGreenColor,
    //                     //                 fontSize: 20))
    //                     //       ]),
    //                     // ),
    //                     // RichText(
    //                     //   text: TextSpan(
    //                     //       text: 'You have a ground?',
    //                     //       style: TextStyle(
    //                     //           color: AppColors.whiteColor, fontSize: 20),
    //                     //       children: <TextSpan>[
    //                     //         TextSpan(
    //                     //             text: ' Register',
    //                     //             style: TextStyle(
    //                     //                 color: AppColors.animationGreenColor,
    //                     //                 fontSize: 20))
    //                     //       ]),
    //                     // ),
    //                     RichText(
    //                       text: TextSpan(
    //                           text: 'Already have an account?',
    //                           style: TextStyle(
    //                               color: AppColors.whiteColor, fontSize: 20),
    //                           children: <TextSpan>[
    //                             TextSpan(
    //                                 text: ' Log in',
    //                                 recognizer: new TapGestureRecognizer()
    //                                   ..onTap = () => {
    //                                         Navigator.push(
    //                                           context,
    //                                           MaterialPageRoute(
    //                                               builder: (context) =>
    //                                                   LoginPage()),
    //                                         )
    //                                       },
    //                                 style: TextStyle(
    //                                     color: AppColors.animationGreenColor,
    //                                     fontSize: 20))
    //                           ]),
    //                     ),
    //                   ],
    //                 )))
    //           ],
    //         ),
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

  Widget userInputWidget(text, icon, dataController) {
    return TextFormField(
      style: TextStyle(color: AppColors.whiteColor),
      validator: MultiValidator([
        RequiredValidator(errorText: "Required"),
        // PatternValidator(r"^[\p{L} ,.'-]*$",
        //     errorText: "Name should only contain alphabets")
      ]),
      controller: dataController,
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

  Widget contactNumberInputWidget(text, icon, dataController) {
    return TextFormField(
      style: TextStyle(color: AppColors.whiteColor),
      validator: MultiValidator([
        RequiredValidator(errorText: "Required"),
        MaxLengthValidator(11, errorText: "11 required"),
        PatternValidator(r'^(?:[+0][1-9])?[0-9]{10,12}$', errorText: 'error'),
      ]),
      controller: dataController,
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

  Widget emailInputWidget(text, icon, dataController) {
    return TextFormField(
      style: TextStyle(color: AppColors.whiteColor),
      validator: MultiValidator([
        RequiredValidator(errorText: "Required"),
        EmailValidator(errorText: " Not valid")
      ]),
      controller: dataController,
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

  Widget signUpButton(BuildContext _context) {
    return Container(
      height: MediaQuery.of(_context).size.height * 0.07,
      decoration: BoxDecoration(
        color: AppColors.animationGreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () async {
          if (validate()) {
            var response = await registerPlayer(name.text, emailAddress.text,
                password.text, contactNumber.text, _date.text, gender);

            if (response.statusCode == 200) {
              Navigator.push(
                _context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
              ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
                  content: Text('${jsonDecode(response.body)['message']}')));
            } else {
              ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
                  content: Text('${jsonDecode(response.body)['message']}')));
            }
          } else {
            ScaffoldMessenger.of(_context)
                .showSnackBar(SnackBar(content: Text('Input Correct Data')));
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
                Divider(color: Colors.black, thickness: 1),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text("OR"),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Divider(color: Colors.black, thickness: 1),
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

  Widget passwordInputWidget(dataController) {
    return TextFormField(
        style: TextStyle(color: AppColors.whiteColor),
        validator: MultiValidator([
          RequiredValidator(errorText: "Required"),
          // MinLengthValidator(5, errorText: "More than 5 reuired"),
        ]),
        controller: dataController,
        obscureText: _isHidden ? false : true,
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
          suffixIcon: IconButton(
            color: AppColors.whiteColor,
            onPressed: () => updateStatus(),
            icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
          ),
        ));
  }

  Widget GenderWidget() {
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
              gender = genders[index];
            } else {
              isSelected[index] = false;
            }
          }
        });
      },
    );
  }
}
