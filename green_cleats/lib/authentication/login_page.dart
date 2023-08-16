import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/GroundOwnerApp/ground_owner_app.dart';
import 'package:green_cleats/apps/PlayersApp/player_app.dart';
import 'package:green_cleats/authentication/registration.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:http/http.dart' as http;

import '../apps/TrainerApp/trainers_app.dart';

bool emailValid = false;
bool passwordValid = false;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

login(emailAddress, password) async {
  try {
    var response = await http.post(Uri.parse("${url}/login"), body: {
      "email_address": emailAddress,
      "password": password,
    });
    print("Response of Login $response");
    return response;
  } catch (e) {
    print("Internet Connectivity Issue $e");
  }
}

class _LoginPageState extends State<LoginPage> {
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

  final email_address =
      // TextEditingController(text: "wali.m.khubaib@szabist.pk");

      // TextEditingController();
      TextEditingController(text: "aadesh@gmail.com");
  final password = TextEditingController(text: "12345");
  var fieldBorder = AppColors.whiteColor;
  String errorMessage = "";

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // bool _isSendingPassword = false;
  @override
  Widget build(BuildContext context) {
    double deviceHeight(BuildContext context) =>
        MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.animationGreenColor,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/stadiumOutline.png"),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(40),
            margin: EdgeInsets.only(
                left: 0,
                top: deviceHeight(context) * 0.25,
                right: 0,
                bottom: 0),
            decoration: BoxDecoration(
              color: AppColors.animationBlueColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                  topRight: Radius.circular(60.0)),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: headerImage(context),
                ),
                Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment:
                        //     MainAxisAlignment.spaceBetween,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: emailInputWidget(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: passwordInputWidget(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              errorMessage,
                              style: TextStyle(
                                  color: AppColors.whiteColor, fontSize: 16),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ForgotPasswordDialog(),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                          ),
                          // _isSendingPassword
                          //     ? CircularProgressIndicator()
                          //     : TextButton(
                          //         onPressed: () {
                          //           if (_formKey.currentState!.validate()) {
                          //             // _showConfirmationDialog();
                          //             showDialog(
                          //               context: context,
                          //               builder: (context) =>
                          //                   ForgotPasswordDialog(),
                          //             );
                          //           }
                          //         },
                          //         child: Text(
                          //           'Forget Password?',
                          //           style:
                          //               TextStyle(color: AppColors.whiteColor),
                          //         ),
                          //       ),
                        ])),
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: loginButton(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: divider(),
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(
                            color: AppColors.whiteColor, fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Sign up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainRegistrationPage()),
                                      )
                                    },
                              style: TextStyle(
                                  color: AppColors.animationGreenColor,
                                  fontSize: 20))
                        ]),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerImage(BuildContext context) {
    return Image.asset(
      "assets/images/greenGC.png",
      height: 100,
      width: 200,
      fit: BoxFit.cover,
    );
  }

  Widget emailInputWidget() {
    return TextFormField(
      validator: MultiValidator([
        RequiredValidator(errorText: "Required"),
        EmailValidator(errorText: " Not valid")
      ]),
      style: TextStyle(color: AppColors.whiteColor),
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w400),
        labelText: "Email",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.animationGreenColor),
        ),
      ),
      controller: email_address,
    );
  }

  Widget passwordInputWidget() {
    return TextFormField(
      style: TextStyle(color: AppColors.whiteColor),
      obscureText: _isHidden ? false : true,
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w400),
        labelText: "Password",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.animationGreenColor),
        ),
        suffixIcon: IconButton(
          color: AppColors.whiteColor,
          onPressed: () => updateStatus(),
          icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      validator: MultiValidator([
        RequiredValidator(errorText: "Password Required"),
        MinLengthValidator(5, errorText: "More than 5 reuired"),
      ]),
      controller: password,
    );
  }

  Widget loginButton(BuildContext _context) {
    return Container(
      height: MediaQuery.of(_context).size.height * 0.07,
      decoration: BoxDecoration(
        color: AppColors.animationGreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () async {
          if (validate()) {
            var response =
                await login(email_address.text.trim(), password.text);
            var iD = json.decode(response.body)["id"];
            var role = json.decode(response.body)["role"];
            print("Role is $role and Id is $iD");
            if (response.statusCode == 200) {
              if (role == "Player") {
                Navigator.push(
                  _context,
                  MaterialPageRoute(
                      builder: (context) => PlayerApp(
                            player_id: iD,
                            index: 0,
                          )),
                );
              } else if (role == "Ground Owner") {
                Navigator.push(
                  _context,
                  MaterialPageRoute(
                      builder: (context) => GroundOwnerApp(
                            groundID: iD,
                          )),
                );
              } else if (role == "Trainer") {
                Navigator.push(
                  _context,
                  MaterialPageRoute(
                      builder: (context) => TrainerApp(
                            trainerId: iD,
                          )),
                );
              }
            } else {
              ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
                  content: Text('${jsonDecode(response.body)['message']}')));
              setState(() {
                errorMessage = jsonDecode(response.body)['message'];
                fieldBorder = AppColors.redColor;
              });
              const CircularProgressIndicator();
            }
          } else {
            ScaffoldMessenger.of(_context)
                .showSnackBar(SnackBar(content: Text('Input Correct Data')));
          }
        },
        child: Center(
          child: Text(
            'LOGIN',
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

class ForgotPasswordDialog extends StatefulWidget {
  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Forgot Password',
        style: TextStyle(
            color: AppColors.animationBlueColor, fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email address',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your email address';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColors.animationGreenColor),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppColors.animationBlueColor)),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _sendPasswordResetEmail();
              Navigator.pop(context);
              _showConfirmationDialog();
            }
          },
          child: Text('Send'),
        ),
      ],
    );
  }

  void _sendPasswordResetEmail() {
    final email = _emailController.text;
    // Implement the code to send the password reset email
    print('Sending password reset email to $email...');
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Password Reset Email Sent'),
        content: Text(
            'A password reset email has been sent to ${_emailController.text}. Please check your email and follow the instructions to reset your password.'),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.animationBlueColor)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}

// Start Forget Password

  // void _showConfirmationDialog() async {
  //   final confirmed = await showDialog<bool>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Confirm'),
  //       content: Text(
  //           'New password will be shared through the email. Are you sure?'),
  //       actions: <Widget>[
  //         TextButton(
  //           child: Text('Cancel'),
  //           onPressed: () => Navigator.of(context).pop(false),
  //         ),
  //         TextButton(
  //           child: Text('Yes'),
  //           onPressed: () => Navigator.of(context).pop(true),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //   if (confirmed!) {
  //     // Send the password to the provided email
  //     final generatedPassword = _generatePassword();
  //     final sent = await _sendEmail(_emailController.text, generatedPassword);
  //     if (sent) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('New password has been sent to your email.'),
  //       ));
  //       // Reset the form and hide the keyboard
  //       _formKey.currentState!.reset();
  //       FocusScope.of(context).unfocus();
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('Failed to send the new password.'),
  //       ));
  //     }
  //   }
  // }

  // Future<bool> _sendEmail(String recipient, String password) async {
  //   // Replace with your email credentials
  //   final username = 'your-gmail-username@gmail.com';
  //   final password = 'your-gmail-password';

  //   final smtpServer = gmail(username, password);

  //   final message = Message()
  //     ..from = Address(username)
  //     ..recipients.add(recipient)
  //     ..subject = 'New Password'
  //     ..text = 'Your new password is: $password';

  //   try {
  //     await send(message, smtpServer);
  //     return true;
  //   } on MailerException catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }

  // String _generatePassword() {
  //   // Replace with your password generation logic
  //   return 'generated-password';
  // }

  //End Forget Password

