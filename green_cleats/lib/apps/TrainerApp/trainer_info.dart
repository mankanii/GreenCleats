import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  var trainerId;

  ProfilePage({super.key, required this.trainerId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _trainerTypeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String _trainerType = "";
  String _name = "";
  String _email = "";
  String _desc = "";
  String _phone = "";
  String _location = "";

  bool _isEditing = false;

  @override
  void dispose() {
    _trainerTypeController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("TrainerId in info is ${widget.trainerId}");
    trainerData(widget.trainerId).then((response) {
      var trainer = json.decode(response.body)['trainer'];
      print("Trainer data: $trainer");
      // print(json.decode(response.body)['trainer']);
      setState(() {
        _name = trainer['full_name'] ?? "";
        _email = trainer['email_address'] ?? "";
        _desc = trainer['description'] ?? "";
        _phone = trainer['contact_number'] ?? "";
        _location = trainer['location'] ?? "";
        _trainerType = trainer['profession_category'] ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text('Trainer Info'),
        elevation: 20,
        actions: [
          MaterialButton(
            onPressed: () => {
              // Save profile changes
              setState(() {
                _isEditing = true;
                _trainerTypeController.text = _trainerType;
                _nameController.text = _name;
                _descriptionController.text = _desc;
                _locationController.text = _location;
                _emailController.text = _email;
                _phoneController.text = _phone;
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
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'Description',
      //         style: TextStyle(
      //           color: AppColors.animationBlueColor,
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(height: 8.0),
      //       TextFormField(
      //         controller: _descriptionController,
      //         maxLines: 3,
      //         decoration: InputDecoration(
      //           hintText: 'Enter your description',
      //           border: OutlineInputBorder(),
      //         ),
      //       ),
      //       SizedBox(height: 16.0),
      //       Text(
      //         'Email',
      //         style: TextStyle(
      //           color: AppColors.animationBlueColor,
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(height: 8.0),
      //       TextFormField(
      //         controller: _emailController,
      //         keyboardType: TextInputType.emailAddress,
      //         decoration: InputDecoration(
      //           hintText: 'Enter your email address',
      //           border: OutlineInputBorder(),
      //         ),
      //       ),
      //       SizedBox(height: 16.0),
      //       Text(
      //         'Phone Number',
      //         style: TextStyle(
      //           color: AppColors.animationBlueColor,
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(height: 8.0),
      //       TextFormField(
      //         controller: _phoneController,
      //         keyboardType: TextInputType.phone,
      //         decoration: InputDecoration(
      //           hintText: 'Enter your phone number',
      //           border: OutlineInputBorder(),
      //         ),
      //       ),
      //       SizedBox(height: 16.0),
      //       Text(
      //         'Location',
      //         style: TextStyle(
      //           color: AppColors.animationBlueColor,
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(height: 8.0),
      //       TextFormField(
      //         controller: _locationController,
      //         decoration: InputDecoration(
      //           hintText: 'Enter your location',
      //           border: OutlineInputBorder(),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            _isEditing
                ? TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                    ),
                  )
                : Text(_name),
            // SizedBox(height: 16.0),
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
            //   'Email',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 18.0,
            //   ),
            // ),
            // SizedBox(height: 8.0),
            // _isEditing
            //     ? TextFormField(
            //         controller: _emailController,
            //         decoration: InputDecoration(
            //           hintText: 'Enter your email',
            //         ),
            //       )
            //     : Text(_email),
            SizedBox(height: 16.0),
            Text(
              'Phone',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            _isEditing
                ? TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: 'Enter your phone',
                    ),
                  )
                : Text(_phone),
            SizedBox(height: 16.0),
            Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            _isEditing
                ? TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter description',
                    ),
                  )
                : Text(_desc),
            SizedBox(height: 16.0),
            Text(
              'Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            _isEditing
                ? TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      hintText: 'Enter location',
                    ),
                  )
                : Text(_location),
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
                      var response = await updateTrainer(
                          widget.trainerId,
                          _nameController.text,
                          _phoneController.text,
                          _descriptionController.text,
                          _locationController.text);

                      if (response.statusCode == 200) {
                        setState(() {
                          // _password = _passwordController.text;
                          // _trainerType = _trainerTypeController.text;
                          _name = _nameController.text;
                          _email = _emailController.text;
                          _phone = _phoneController.text;
                          _desc = _descriptionController.text;
                          _location = _locationController.text;
                          _isEditing = false;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("${json.decode(response.body)['message']}"),
                          duration: const Duration(seconds: 2),
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
