import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:http/http.dart' as http;

import '../../api/apis.dart';

class GroundInfo extends StatefulWidget {
  var groundID;

  GroundInfo({super.key, required this.groundID});
  @override
  _GroundInfoState createState() => _GroundInfoState();
}

class _GroundInfoState extends State<GroundInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _feesController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String _name = '-';
  String _fees = "-";
  String _desc = "-";
  String _location = "-";

  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _feesController.dispose();
    _descController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future groundData(groundId) async {
    try {
      var response = await http.get(Uri.parse("$url/ground/$groundId"));
      if (response.statusCode == 200) {
        setState(() {
          final _ground = json.decode(response.body)["ground"];

          _name = _ground["ground_name"];
          _fees = _ground["fees"];
          _desc = _ground["ground_description"];
          _location = _ground["location"];
        });
      }
    } catch (e) {
      throw Exception("Failed To Load Data. Check your Internet Connection");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groundData(widget.groundID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text('Ground Information'),
        elevation: 20,
        actions: [
          MaterialButton(
            onPressed: () => {
              setState(() {
                _isEditing = true;
                _nameController.text = _name;
                _feesController.text = _fees;
                _descController.text = _desc;
                _locationController.text = _location;
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
              'Ground Name',
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
            SizedBox(height: 16.0),
            Text(
              'Ground Fees',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            _isEditing
                ? TextFormField(
                    controller: _feesController,
                    decoration: InputDecoration(
                      hintText: 'Enter ground fees',
                    ),
                  )
                : Text(_fees),
            SizedBox(height: 16.0),
            Text(
              'Ground Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            _isEditing
                ? TextFormField(
                    controller: _descController,
                    decoration: InputDecoration(
                      hintText: 'Enter ground description',
                    ),
                  )
                : Text(_desc),
            SizedBox(height: 16.0),
            Text(
              'Ground Location',
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
                      hintText: 'Enter ground location',
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
                    onPressed: () {
                      setState(() {
                        _name = _nameController.text;
                        _fees = _feesController.text;
                        _desc = _descController.text;
                        _location = _locationController.text;
                        updateGround(
                            _name, _fees, _desc, _location, widget.groundID);
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
