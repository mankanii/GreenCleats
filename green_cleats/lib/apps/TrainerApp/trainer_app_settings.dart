import 'package:flutter/material.dart';
import 'package:green_cleats/utils/colors.dart';

class TrainerSettings extends StatefulWidget {
  @override
  _TrainerSettingsState createState() => _TrainerSettingsState();
}

class _TrainerSettingsState extends State<TrainerSettings> {
  // Text editing controllers
  final TextEditingController _currentpasswordController =
      TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();

  // final TextEditingController _trainerTypeController = TextEditingController();
  // final TextEditingController _nameController = TextEditingController();

  // Initial values
  String _password = '';
  String _newpassword = '';
  // String _trainerType = 'Personal Trainer';
  // String _name = 'John Doe';

  // Editing state
  bool _isEditing = false;

  @override
  void dispose() {
    _currentpasswordController.dispose();
    _newpasswordController.dispose();

    // _trainerTypeController.dispose();
    // _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text('Settings'),
        elevation: 20,
        actions: [
          MaterialButton(
            onPressed: () => {
              setState(() {
                _isEditing = true;
                _currentpasswordController.text = _password;
                _newpasswordController.text = _newpassword;

                // _trainerTypeController.text = _trainerType;
                // _nameController.text = _name;
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
                    controller: _currentpasswordController,
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
                    obscureText: true,
                    controller: _newpasswordController,
                    decoration: InputDecoration(
                      hintText: 'Enter new password',
                    ),
                  )
                : Text(""),
            // Text(
            //   'Type of Trainer',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 18.0,
            //   ),
            // ),
            // SizedBox(height: 8.0),
            // _isEditing
            //     ? TextFormField(
            //         controller: _trainerTypeController,
            //         decoration: InputDecoration(
            //           hintText: 'Enter type of trainer',
            //         ),
            //       )
            //     : Text(_trainerType),
            // SizedBox(height: 16.0),
            // Text(
            //   'Name',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 18.0,
            //   ),
            // ),
            // SizedBox(height: 8.0),
            // _isEditing
            //     ? TextFormField(
            //         controller: _nameController,
            //         decoration: InputDecoration(
            //           hintText: 'Enter your name',
            //         ),
            //       )
            //     : Text(_name),
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
                    onPressed: () {
                      setState(() {
                        _password = _currentpasswordController.text;
                        _newpassword = _newpasswordController.text;

                        // _trainerType = _trainerTypeController.text;
                        // _name = _nameController.text;
                        _isEditing = false;
                      });
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
