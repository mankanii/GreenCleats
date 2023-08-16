import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/TrainerApp/trainers_app.dart';
import 'package:green_cleats/utils/colors.dart';

class PackageDetailsPage extends StatefulWidget {
  var trainerId;

  PackageDetailsPage({super.key, required this.trainerId});
  @override
  _PackageDetailsPageState createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
  final TextEditingController _packageNameController = TextEditingController();
  final TextEditingController _packagePriceController = TextEditingController();
  final TextEditingController _packageDescriptionController =
      TextEditingController();

  List _packages = [];

  bool _isEditing = false;
  int _selectedIndex = -1;

  void _editPackage() {
    var package = {
      "trainer_id": widget.trainerId,
      "package_name": _packageNameController.text,
      "package_price": int.parse(_packagePriceController.text),
      "package_description": _packageDescriptionController.text,
    };
    setState(() {
      _packages[_selectedIndex] = package;
      _packageNameController.clear();
      _packagePriceController.clear();
      _packageDescriptionController.clear();
      _isEditing = false;
      _selectedIndex = -1;
    });
  }

  void _showEditDialog(int index) {
    setState(() {
      _selectedIndex = index;
      _packageNameController.text = _packages[index]["package_name"];
      _packagePriceController.text =
          _packages[index]["package_price"].toString();
      _packageDescriptionController.text =
          _packages[index]["package_description"];
      _isEditing = true;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.animationBlueColor.withOpacity(0.85),
          title: Text(
            'Edit Package',
            style: TextStyle(
              color: AppColors.whiteColor, // Change text color here
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _packageNameController,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold // Change text color here
                      ),
                  decoration: InputDecoration(
                    labelText: 'Package Name',
                    hintText: 'Enter the package name',
                    hintStyle: TextStyle(
                      color: AppColors.whiteColor, // Change text color here
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.whiteColor, // Change text color here
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _packagePriceController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold // Change text color here
                      ),
                  decoration: InputDecoration(
                    labelText: 'Package Price',
                    hintText: 'Enter the package price',
                    hintStyle: TextStyle(
                      color: AppColors.whiteColor, // Change text color here
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.whiteColor, // Change text color here
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _packageDescriptionController,
                  maxLines: 3,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold // Change text color here
                      ),
                  decoration: InputDecoration(
                    labelText: 'Package Description',
                    hintText: 'Enter the package description',
                    hintStyle: TextStyle(
                      color: AppColors.whiteColor, // Change text color here
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.whiteColor, // Change text color here
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_isEditing) {
                  _editPackage();
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPackageList() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/grounds.jpg",
              ),
              opacity: 100,
              fit: BoxFit.cover)),
      // color: AppColors.backgroundColor,
      child: ListView.builder(
        itemCount: _packages.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              shadowColor: AppColors.animationGreenColor,
              elevation: 20,
              color: AppColors.backgroundColor,
              child: ListTile(
                onTap: () {
                  _showEditDialog(index);
                },
                title: Text(
                  _packages[index]["package_name"],
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.animationBlueColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 8.0),
                    Text(
                      'Price: ${_packages[index]["package_price"].toString()}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.animationBlueColor),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      _packages[index]["package_description"],
                      style: TextStyle(
                        color: AppColors.animationBlueColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: AppColors.khakiColor),
                  onPressed: () {
                    setState(() {
                      _packages.removeAt(index);
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrainerPackages(widget.trainerId).then((response) => {
          if (response.statusCode == 200)
            {
              setState(() {
                print("Packages:${json.decode(response.body)['packages']}");
                var data = json.decode(response.body)['packages'];
                for (var package in data) {
                  _packages.add(package);
                }
              })
            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("${json.decode(response.body)['message']}"),
                duration: const Duration(seconds: 2),
              ))
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text('Update Packages'),
        elevation: 20,
        actions: [
          MaterialButton(
            onPressed: () async {
              // Save profile changes
              print(_packages);
              addTrainerPackages(_packages).then((response) => {
                    if (response.statusCode == 200)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainerApp(
                                    trainerId: widget.trainerId,
                                  )),
                        )
                      }
                    else if (response.statusCode != 200)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("${json.decode(response.body)['message']}"),
                          duration: const Duration(seconds: 2),
                        ))
                      }
                    else
                      {
                        new CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      }
                  });
            },
            color: AppColors.animationGreenColor,
            child: Center(
                child: Text(
              "Save",
              style: TextStyle(color: AppColors.whiteColor),
            )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              // padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.animationBlueColor,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      "Tap on the card to edit the package.",
                      style: TextStyle(
                          color: AppColors.animationBlueColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: _buildPackageList(),
            ),
            Divider(
              thickness: 1.0,
              color: AppColors.animationBlueColor.withOpacity(0.08),
              height: 32.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add Package"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _packageNameController,
                            decoration: InputDecoration(
                              labelText: 'Package Name',
                              hintText: 'Enter the package name',
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            controller: _packagePriceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Package Price',
                              hintText: 'Enter the package price',
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            controller: _packageDescriptionController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: 'Package Description',
                              hintText: 'Enter the package description',
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            var package = {
                              "trainer_id": widget.trainerId,
                              "package_name": _packageNameController.text,
                              "package_price":
                                  int.parse(_packagePriceController.text),
                              "package_description":
                                  _packageDescriptionController.text,
                            };
                            setState(() {
                              _packages.add(package);
                              _packageNameController.clear();
                              _packagePriceController.clear();
                              _packageDescriptionController.clear();
                            });
                            Navigator.pop(context);
                          },
                          child: Text('Add Package'),
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.animationBlueColor,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.animationBlueColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    'Add New Package',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
