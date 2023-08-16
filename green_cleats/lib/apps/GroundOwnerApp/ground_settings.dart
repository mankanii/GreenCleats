import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/GroundOwnerApp/ground_owner_app.dart';
import 'package:green_cleats/utils/colors.dart';

class GroundSettings extends StatefulWidget {
  var groundId;

  GroundSettings({super.key, required this.groundId});
  @override
  _GroundSettingsState createState() => _GroundSettingsState();
}

class _GroundSettingsState extends State<GroundSettings> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newController = TextEditingController();

  String _password = '';
  String _new = '';

  bool _isEditing = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _newController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text('Change Password'),
        elevation: 20,
        actions: [
          MaterialButton(
            onPressed: () => {
              setState(() {
                _isEditing = true;
                _passwordController.text = _password;
                _newController.text = _new;
              }),
            },
            color: AppColors.animationGreenColor,
            child: Center(
                child: Text(
              "Edit",
              style: TextStyle(color: AppColors.whiteColor),
            )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Current Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            _isEditing
                ? TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Enter current password',
                    ),
                  )
                : Text(""),
            SizedBox(height: 16.0),
            Text(
              'New Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            _isEditing
                ? TextFormField(
                    controller: _newController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                    ),
                  )
                : Text(""),
            SizedBox(height: 32.0),
            if (_isEditing)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.khakiColor)),
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            AppColors.animationBlueColor)),
                    onPressed: () async {
                      setState(() {
                        _password = _passwordController.text;
                        _new = _newController.text;
                        _isEditing = false;
                      });
                      var response = await changePassword(
                          widget.groundId, _password, _new);
                      if (response.statusCode == 200) {
                        _passwordController.clear();
                        _newController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GroundOwnerApp(groundID: widget.groundId)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("${json.decode(response.body)['message']}"),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
