import 'package:flutter/material.dart';
import 'package:green_cleats/authentication/ground_registration_page.dart';
import 'package:green_cleats/authentication/main_registration_page.dart';
import 'package:green_cleats/authentication/trainer_registration_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/authentication/login_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// //Method Start
// registerPlayer(
//   name,
//   email_address,
//   password,
//   contact_number,
//   date_of_birth,
//   gender,
// ) async {
//   var response = await http.post(Uri.parse("${url}/registerPlayer"), body: {
//     "name": name,
//     "email_address": email_address,
//     "password": password,
//     "contact_number": contact_number,
//     "date_of_birth": date_of_birth,
//     "gender": gender,
//   });
//   return response;
// }
// //Method End

// //Method Start
// registerGround(
//   name,
//   email,
//   phone_number,
//   ground_name,
//   location,
// ) async {
//   var response =
//       await http.post(Uri.parse("${url}/registerGroundOwner"), body: {
//     "full_name": name,
//     "email_address": email,
//     "contact_number": phone_number,
//     "ground_name": ground_name,
//     "location": location,
//   });
//   return response;
// }
// //Method End

// // Methods Start
// registerTrainer(
//   full_name,
//   email_address,
//   contact_number,
//   date_of_birth,
//   profession_category,
//   gender,
// ) async {
//   var response = await http.post(Uri.parse("${url}/registerTrainer"), body: {
//     "full_name": full_name,
//     "email_address": email_address,
//     "contact_number": contact_number,
//     "date_of_birth": date_of_birth,
//     "profession_category": profession_category,
//     "gender": gender,
//   });
//   return response;
// }
// // Methods End

// const List<String> list = <String>[
//   'Football Coach',
//   'Physical Trainer',
//   'Gym Trainer',
//   'Other'
// ];

class MainRegistrationPage extends StatefulWidget {
  const MainRegistrationPage({super.key});

  @override
  _MainRegistrationPageState createState() => _MainRegistrationPageState();
}

class _MainRegistrationPageState extends State<MainRegistrationPage> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    // PlayerRegistration(),
    // GroundRegistration(),
    // TrainerRegistration(),
    const MainRegistration(),
    const GroundRegistrationPage(),
    const TrainerRegistrationPage()
  ];

  void _onPageChanged(int? index) {
    setState(() {
      _currentPageIndex = index ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.animationGreenColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/stadiumOutline.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: DropdownButton(
                value: _currentPageIndex,
                style: TextStyle(
                  color: AppColors.whiteColor, // text color
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                underline: Container(
                  height: 2,
                  color: AppColors.whiteColor, // underline color
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.khakiColor, // arrow icon color
                ),
                dropdownColor: AppColors.animationGreenColor,
                items: const [
                  DropdownMenuItem(
                    value: 0,
                    child: Text('Player Registration'),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Ground Registration'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Trainer Registration'),
                  ),
                ],
                onChanged: _onPageChanged,
              ),
            ),
            // Tooltip(
            //   message: 'Click to view information',
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.sports_soccer,
            //       size: 25,
            //       color: AppColors.whiteColor,
            //     ),
            //     tooltip: "Click Me!",
            //     onPressed: () {
            //       showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return AlertDialog(
            //             title: Text('Information'),
            //             content: Text(
            //               'Register yourself based on the type. Select the appropriate option.',
            //               style: TextStyle(fontWeight: FontWeight.bold),
            //             ),
            //             actions: [
            //               TextButton(
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                 },
            //                 child: Text('OK'),
            //               ),
            //             ],
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              // child: _pages[_currentPageIndex],
              child: Container(
                  padding: const EdgeInsets.all(40),
                  margin: const EdgeInsets.only(
                      left: 0, top: 10, right: 0, bottom: 0),
                  decoration: BoxDecoration(
                    color: AppColors.animationBlueColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        topRight: Radius.circular(60.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: headerImage(context),
                      ),
                      _pages[_currentPageIndex],
                      divider(),
                      RichText(
                        text: TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Log in',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()),
                                          )
                                        },
                                  style: TextStyle(
                                      color: AppColors.animationGreenColor,
                                      fontSize: 20))
                            ]),
                      ),
                    ],
                  )),
            ),
          ],
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
              children: const <Widget>[
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: const <Widget>[
                Text("OR"),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: const <Widget>[
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

// class PlayerRegistration extends StatefulWidget {
//   const PlayerRegistration({super.key});

//   @override
//   _PlayerRegistrationPageState createState() => _PlayerRegistrationPageState();
// }

// class _PlayerRegistrationPageState extends State<PlayerRegistration> {
//   final name = TextEditingController();
//   final emailAddress = TextEditingController();
//   final password = TextEditingController();
//   final contactNumber = TextEditingController();
//   final dateOfBirth = TextEditingController();
//   List<bool> isSelected = [true, false, false];
//   List<String> genders = ["Male", "Female", "Other"];
//   String? gender = "Male";

//   bool _isHidden = false;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool validate() {
//     if (_formKey.currentState!.validate()) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void updateStatus() {
//     setState(() {
//       _isHidden = !_isHidden;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         userInputWidget("Name", Icons.person, name),
//         emailInputWidget("Email", Icons.email_rounded, emailAddress),
//         passwordInputWidget(password),
//         contactNumberInputWidget(
//             "Phone Number", Icons.phone_callback_rounded, contactNumber),
//         datePicker(context),
//         GenderWidget(),
//         signUpButton(context),
//         divider(),
//       ],
//     ));
//     // return Container(
//     //   padding: EdgeInsets.all(20),
//     //   child: Column(
//     //     children: [
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Name',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Email Address',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Password',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Contact Number',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Date of Birth',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Gender',
//     //         ),
//     //       ),
//     //       SizedBox(height: 30),
//     //       ElevatedButton(
//     //         onPressed: () {},
//     //         child: Text('Submit'),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }

//   Widget userInputWidget(text, icon, dataController) {
//     return TextFormField(
//       style: TextStyle(color: AppColors.whiteColor),
//       validator: MultiValidator([
//         RequiredValidator(errorText: "Required"),
//         // PatternValidator(r"^[\p{L} ,.'-]*$",
//         //     errorText: "Name should only contain alphabets")
//       ]),
//       controller: dataController,
//       decoration: InputDecoration(
//         icon: Icon(icon, color: AppColors.whiteColor),
//         labelStyle: TextStyle(
//             color: AppColors.whiteColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w400),
//         labelText: text,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: AppColors.whiteColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AppColors.animationGreenColor),
//         ),
//       ),
//     );
//   }

//   Widget contactNumberInputWidget(text, icon, dataController) {
//     return TextFormField(
//       style: TextStyle(color: AppColors.whiteColor),
//       validator: MultiValidator([
//         RequiredValidator(errorText: "Required"),
//         MaxLengthValidator(11, errorText: "11 required"),
//         PatternValidator(r'^(?:[+0][1-9])?[0-9]{10,12}$', errorText: 'error'),
//       ]),
//       controller: dataController,
//       decoration: InputDecoration(
//         icon: Icon(icon, color: AppColors.whiteColor),
//         labelStyle: TextStyle(
//             color: AppColors.whiteColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w400),
//         labelText: text,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: AppColors.whiteColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AppColors.animationGreenColor),
//         ),
//       ),
//     );
//   }

//   Widget emailInputWidget(text, icon, dataController) {
//     return TextFormField(
//       style: TextStyle(color: AppColors.whiteColor),
//       validator: MultiValidator([
//         RequiredValidator(errorText: "Required"),
//         EmailValidator(errorText: " Not valid")
//       ]),
//       controller: dataController,
//       decoration: InputDecoration(
//         icon: Icon(icon, color: AppColors.whiteColor),
//         labelStyle: TextStyle(
//             color: AppColors.whiteColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w400),
//         labelText: text,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: AppColors.whiteColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AppColors.animationGreenColor),
//         ),
//       ),
//     );
//   }

//   Widget signUpButton(BuildContext _context) {
//     return Container(
//       height: MediaQuery.of(_context).size.height * 0.07,
//       decoration: BoxDecoration(
//         color: AppColors.animationGreenColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: MaterialButton(
//         onPressed: () async {
//           if (validate()) {
//             var response = await registerPlayer(name.text, emailAddress.text,
//                 password.text, contactNumber.text, _date.text, gender);

//             if (response.statusCode == 200) {
//               Navigator.push(
//                 _context,
//                 MaterialPageRoute(builder: (context) => const LoginPage()),
//               );
//               ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
//                   content: Text('${jsonDecode(response.body)['message']}')));
//             } else {
//               ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
//                   content: Text('${jsonDecode(response.body)['message']}')));
//             }
//           } else {
//             ScaffoldMessenger.of(_context)
//                 .showSnackBar(SnackBar(content: Text('Input Correct Data')));
//           }
//         },
//         child: Center(
//           child: Text(
//             'SIGN UP',
//             style: TextStyle(
//                 color: AppColors.whiteColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w400),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget divider() {
//     return Container(
//       margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//       child: (Row(
//         children: <Widget>[
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 Divider(color: Colors.black, thickness: 1),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 Text("OR"),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 Divider(color: Colors.black, thickness: 1),
//               ],
//             ),
//           ),
//         ],
//       )),
//     );
//   }

//   TextEditingController _date = TextEditingController();
//   Widget datePicker(context) {
//     return TextField(
//       controller: _date,
//       style: TextStyle(
//           color: AppColors.whiteColor,
//           fontSize: 20,
//           fontWeight: FontWeight.w400),
//       decoration: InputDecoration(
//         icon: Icon(Icons.calendar_today_rounded, color: AppColors.whiteColor),
//         labelText: "Date of birth",
//         labelStyle: TextStyle(
//             color: AppColors.whiteColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w400),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: AppColors.whiteColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AppColors.animationGreenColor),
//         ),
//       ),
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(2000),
//             lastDate: DateTime(2101));

//         if (pickedDate != null) {
//           setState(() {
//             _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//           });
//         }
//       },
//     );
//   }

//   Widget passwordInputWidget(dataController) {
//     return TextFormField(
//         style: TextStyle(color: AppColors.whiteColor),
//         validator: MultiValidator([
//           RequiredValidator(errorText: "Required"),
//           // MinLengthValidator(5, errorText: "More than 5 reuired"),
//         ]),
//         controller: dataController,
//         obscureText: _isHidden ? false : true,
//         decoration: InputDecoration(
//           icon: Icon(Icons.lock_rounded, color: AppColors.whiteColor),
//           labelStyle: TextStyle(
//               color: AppColors.whiteColor,
//               fontSize: 20,
//               fontWeight: FontWeight.w400),
//           labelText: "Password",
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: AppColors.whiteColor),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColors.animationGreenColor),
//           ),
//           suffixIcon: IconButton(
//             color: AppColors.whiteColor,
//             onPressed: () => updateStatus(),
//             icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
//           ),
//         ));
//   }

//   Widget GenderWidget() {
//     return ToggleButtons(
//       isSelected: isSelected,
//       borderRadius: BorderRadius.circular(10),
//       color: AppColors.whiteColor,
//       fillColor: AppColors.animationGreenColor,
//       selectedColor: AppColors.whiteColor,
//       splashColor: AppColors.animationGreenColor,
//       children: const <Widget>[
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text("Male"),
//         ),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text("Female"),
//         ),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text("Other"),
//         ),
//       ],
//       onPressed: (int newIndex) {
//         setState(() {
//           for (int index = 0; index < isSelected.length; index++) {
//             if (index == newIndex) {
//               isSelected[index] = true;
//               gender = genders[index];
//             } else {
//               isSelected[index] = false;
//             }
//           }
//         });
//       },
//     );
//   }
// }

// class GroundRegistration extends StatefulWidget {
//   const GroundRegistration({super.key});

//   @override
//   _GroundRegistrationPageState createState() => _GroundRegistrationPageState();
// }

// class _GroundRegistrationPageState extends State<GroundRegistration> {
//   var name = TextEditingController();
//   var email = TextEditingController();
//   var phone_number = TextEditingController();
//   var ground_name = TextEditingController();
//   var location = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         userInputWidget("Name", Icons.person, name),
//         userInputWidget("Email", Icons.email_rounded, email),
//         userInputWidget(
//             "Phone Number", Icons.phone_callback_rounded, phone_number),
//         userInputWidget(
//             "Ground Name", Icons.phone_callback_rounded, ground_name),
//         userInputWidget("Location", Icons.phone_callback_rounded, location),
//         signUpButton(context),
//         divider(),
//       ],
//     ));
//     // return Container(
//     //   padding: EdgeInsets.all(20),
//     //   child: Column(
//     //     children: [
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Name',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Email Address',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Phone Number',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Ground Name',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Location',
//     //         ),
//     //       ),
//     //       SizedBox(height: 30),
//     //       ElevatedButton(
//     //         onPressed: () {},
//     //         child: Text('Submit'),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }

//   Widget userInputWidget(text, icon, myController) {
//     return TextFormField(
//       style: TextStyle(color: AppColors.whiteColor),
//       controller: myController,
//       decoration: InputDecoration(
//         icon: Icon(icon, color: AppColors.whiteColor),
//         labelStyle: TextStyle(
//             color: AppColors.whiteColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w400),
//         labelText: text,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: AppColors.whiteColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AppColors.animationGreenColor),
//         ),
//       ),
//     );
//   }

//   Widget signUpButton(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.07,
//       decoration: BoxDecoration(
//         color: AppColors.animationGreenColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: MaterialButton(
//         onPressed: () async {
//           var response = await registerGround(name.text, email.text,
//               phone_number.text, ground_name.text, location.text);

//           if (response.statusCode == 200) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const LoginPage()),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text('${jsonDecode(response.body)['message']}')));
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text('${jsonDecode(response.body)['message']}')));
//           }
//         },
//         child: Center(
//           child: Text(
//             'SIGN UP',
//             style: TextStyle(
//                 color: AppColors.whiteColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w400),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget divider() {
//     return Container(
//       margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//       child: (Row(
//         children: <Widget>[
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 const Divider(color: Colors.black, thickness: 1),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 const Text("OR"),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 const Divider(color: Colors.black, thickness: 1),
//               ],
//             ),
//           ),
//         ],
//       )),
//     );
//   }

//   TextEditingController _date = TextEditingController();
//   Widget datePicker(context) {
//     return TextField(
//       controller: _date,
//       style: TextStyle(
//           color: AppColors.whiteColor,
//           fontSize: 20,
//           fontWeight: FontWeight.w400),
//       decoration: InputDecoration(
//         icon: Icon(Icons.calendar_today_rounded, color: AppColors.whiteColor),
//         labelText: "Date of birth",
//         labelStyle: TextStyle(
//             color: AppColors.whiteColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w400),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: AppColors.whiteColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AppColors.animationGreenColor),
//         ),
//       ),
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(2000),
//             lastDate: DateTime(2101));

//         if (pickedDate != null) {
//           setState(() {
//             _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//           });
//         }
//       },
//     );
//   }

//   Widget passwordInputWidget() {
//     return TextFormField(
//         obscureText: true,
//         decoration: InputDecoration(
//           icon: Icon(Icons.lock_rounded, color: AppColors.whiteColor),
//           labelStyle: TextStyle(
//               color: AppColors.whiteColor,
//               fontSize: 20,
//               fontWeight: FontWeight.w400),
//           labelText: "Password",
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: AppColors.whiteColor),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColors.animationGreenColor),
//           ),
//         ));
//   }
// }

// class TrainerRegistration extends StatefulWidget {
//   const TrainerRegistration({super.key});

//   @override
//   _TrainerRegistrationPageState createState() =>
//       _TrainerRegistrationPageState();
// }

// class _TrainerRegistrationPageState extends State<TrainerRegistration> {
//   var _name = TextEditingController();
//   var _email = TextEditingController();
//   var _phone_number = TextEditingController();
//   var _date = TextEditingController();
//   String _dropdownValue = list.first;
//   var _gender;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         // height: MediaQuery.of(context).size.height * 0.7,
//         child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         userInputWidget("Name", Icons.person, _name),
//         Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: userInputWidget("Email", Icons.email_rounded, _email),
//         ),
//         userInputWidget(
//             "Phone Number", Icons.phone_callback_rounded, _phone_number),
//         datePicker(context),
//         expertiseDropDown(),
//         GenderWidget(),
//         signUpButton(context),
//         divider(),
//         // RichText(
//         //   text: TextSpan(
//         //       text: 'Already have an account?',
//         //       style: TextStyle(color: AppColors.whiteColor, fontSize: 20),
//         //       children: <TextSpan>[
//         //         TextSpan(
//         //             text: ' Log in',
//         //             recognizer: new TapGestureRecognizer()
//         //               ..onTap = () => {
//         //                     Navigator.push(
//         //                       context,
//         //                       MaterialPageRoute(
//         //                           builder: (context) => const LoginPage()),
//         //                     )
//         //                   },
//         //             style: TextStyle(
//         //                 color: AppColors.animationGreenColor, fontSize: 20))
//         //       ]),
//         // ),
//       ],
//     ));
//     // return Container(
//     //   padding: EdgeInsets.all(20),
//     //   child: Column(
//     //     children: [
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Name',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Email Address',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Phone Number',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Contact Number',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Child\'s Name',
//     //         ),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           labelText: 'Child\'s Age',
//     //         ),
//     //       ),
//     //       SizedBox(height: 30),
//     //       ElevatedButton(
//     //         onPressed: () {},
//     //         child: Text('Submit'),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }

//   Widget userInputWidget(text, icon, myController) {
//     return TextFormField(
//       style: TextStyle(color: AppColors.whiteColor),
//       controller: myController,
//       decoration: InputDecoration(
//         icon: Icon(icon, color: AppColors.whiteColor),
//         labelStyle: TextStyle(
//             color: AppColors.whiteColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w400),
//         labelText: text,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: AppColors.whiteColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AppColors.animationGreenColor),
//         ),
//       ),
//     );
//   }

//   Widget signUpButton(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.07,
//       decoration: BoxDecoration(
//         color: AppColors.animationGreenColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: MaterialButton(
//         onPressed: () async {
//           var response = await registerTrainer(_name.text, _email.text,
//               _phone_number.text, _date.text, _dropdownValue, _gender);

//           if (response.statusCode == 200) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const LoginPage()),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text('${jsonDecode(response.body)['message']}')));
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text('${jsonDecode(response.body)['message']}')));
//           }
//         },
//         child: Center(
//           child: Text(
//             'SIGN UP',
//             style: TextStyle(
//                 color: AppColors.whiteColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w400),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget divider() {
//     return Container(
//       margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//       child: (Row(
//         children: <Widget>[
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 const Divider(color: Colors.black, thickness: 1),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 const Text("OR"),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 const Divider(color: Colors.black, thickness: 1),
//               ],
//             ),
//           ),
//         ],
//       )),
//     );
//   }

//   Widget datePicker(context) {
//     return TextField(
//       controller: _date,
//       style: TextStyle(
//           color: AppColors.whiteColor,
//           fontSize: 20,
//           fontWeight: FontWeight.w400),
//       decoration: InputDecoration(
//         icon: Icon(Icons.calendar_today_rounded, color: AppColors.whiteColor),
//         labelText: "Date of birth",
//         labelStyle: TextStyle(
//             color: AppColors.whiteColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w400),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: AppColors.whiteColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AppColors.animationGreenColor),
//         ),
//       ),
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(2000),
//             lastDate: DateTime(2101));

//         if (pickedDate != null) {
//           setState(() {
//             _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//           });
//         }
//       },
//     );
//   }

//   Widget passwordInputWidget() {
//     return TextFormField(
//         obscureText: true,
//         decoration: InputDecoration(
//           icon: Icon(Icons.lock_rounded, color: AppColors.whiteColor),
//           labelStyle: TextStyle(
//               color: AppColors.whiteColor,
//               fontSize: 20,
//               fontWeight: FontWeight.w400),
//           labelText: "Password",
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: AppColors.whiteColor),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColors.animationGreenColor),
//           ),
//         ));
//   }

//   Widget expertiseDropDown() {
//     return DropdownButton<String>(
//       value: _dropdownValue,
//       dropdownColor: AppColors.animationGreenColor,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       borderRadius: BorderRadius.circular(10),
//       style: TextStyle(
//           color: AppColors.whiteColor,
//           fontSize: 20,
//           fontWeight: FontWeight.w400),
//       underline: Container(
//         height: 2,
//         color: AppColors.whiteColor,
//       ),
//       onChanged: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           _dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }

//   List<String> genders = ["Male", "Female", "Other"];
//   List<bool> isSelected = [true, false, false];

//   Widget GenderWidget() {
//     return ToggleButtons(
//       isSelected: isSelected,
//       borderRadius: BorderRadius.circular(10),
//       color: AppColors.whiteColor,
//       fillColor: AppColors.animationGreenColor,
//       selectedColor: AppColors.whiteColor,
//       splashColor: AppColors.animationGreenColor,
//       children: const <Widget>[
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text("Male"),
//         ),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text("Female"),
//         ),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text("Other"),
//         ),
//       ],
//       onPressed: (int newIndex) {
//         setState(() {
//           for (int index = 0; index < isSelected.length; index++) {
//             if (index == newIndex) {
//               isSelected[index] = true;
//               _gender = genders[index];
//             } else {
//               isSelected[index] = false;
//             }
//           }
//         });
//       },
//     );
//   }
// }

Widget headerImage(BuildContext context) {
  return Image.asset(
    "assets/images/greenGC.png",
    height: 100,
    width: 200,
    fit: BoxFit.cover,
  );
}
