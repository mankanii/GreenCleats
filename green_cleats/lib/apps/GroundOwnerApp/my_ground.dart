import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';
import 'ground_owner_app.dart';

class TimeSlot {
  final DateTime date;
  final String time;

  TimeSlot({required this.date, required this.time});
}

class MyGround extends StatefulWidget {
  var groundID;

  MyGround({Key? key, required this.groundID}) : super(key: key);

  @override
  _MyGroundState createState() => _MyGroundState();
}

class _MyGroundState extends State<MyGround> {
  final List<TimeSlot> _timeSlots = [];

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();
  List _timeList = [];
  List _timeList1 = [];

  void _addTimeToList() {
    var newTime = {
      'date': _selectedDate,
      'start_time': _selectedStartTime,
      'end_time': _selectedEndTime,
    };
    var newTime1 = {
      'date': DateFormat('yyyy-MM-dd').format(_selectedDate).toString(),
      'start_time': _selectedStartTime.format(context),
      'end_time': _selectedEndTime.format(context),
    };
    setState(() {
      _timeList.add(newTime);
      _timeList1.add(newTime1);
    });
  }

  String _selectedTime = '';
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController ground_fee = TextEditingController();
  final TextEditingController ground_description = TextEditingController();
  final TextEditingController location = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text(
          "Sportswing",
          style: TextStyle(
              color: AppColors.whiteColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              // On "Save" button Click
              try {
                var response = await addSlot(_timeList1, "${widget.groundID}");
                if (response.statusCode == 200) {
                  print("Slots posted");
                }
              } catch (e) {
                print("Error Found $e");
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GroundOwnerApp(
                          groundID: widget.groundID,
                        )),
              );
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a date:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.animationBlueColor),
            ),
            //-------------------------------------------------------------
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (newDate != null) {
                  setState(() {
                    _selectedDate = newDate;
                    _timeList.clear();
                    _timeList1.clear();
                  });
                }
              },
              child: Row(
                children: [
                  Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.calendar_today),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Select Start Time:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedStartTime,
                );
                if (newTime != null) {
                  setState(() {
                    _selectedStartTime = newTime;
                  });
                }
              },
              child: Row(
                children: [
                  Text(
                    '${_selectedStartTime.hour}:${_selectedStartTime.minute}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.access_time),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Select End Time:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedEndTime,
                );
                if (newTime != null) {
                  setState(() {
                    _selectedEndTime = newTime;
                  });
                }
              },
              child: Row(
                children: [
                  Text(
                    '${_selectedEndTime.hour}:${_selectedEndTime.minute}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.access_time),
                ],
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time slots',
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.animationBlueColor,
                      fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.animationBlueColor)),
                  onPressed: _addTimeToList,
                  child: Text('Add Time'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: _timeList.isEmpty
                  ? Text('No time slots added')
                  : ListView.builder(
                      itemCount: _timeList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> time = _timeList[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              '${time['date'].day}/${time['date'].month}/${time['date'].year}',
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Time: ${time['start_time'].hour}:${time['start_time'].minute}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'End Time: ${time['end_time'].hour}:${time['end_time'].minute}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _timeList.removeAt(index);
                                  _timeList1.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                        // } else {
                        //   return SizedBox.shrink();
                        // }
                      },
                    ),
            ),
            SizedBox(
              height: 7,
            ),
            Divider(
              thickness: 1.0,
              color: AppColors.animationBlueColor.withOpacity(0.08),
              height: 32.0,
            ),
            // Ground Fees
            // buildTextField("Ground Fees", "Type grounds fees /hr"),
            // // Description
            // buildTextField("Description", "Type grounds description"),
            // // Location
            // buildTextField("Location", "Type grounds location"),
            // Upload Images
          ],
        ),
      ),
    );
  }

  // Padding buildTextField(String labelText, String placeholder) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 7, bottom: 7),
  //     child: TextField(
  //       style: TextStyle(color: AppColors.animationBlueColor),
  //       decoration: InputDecoration(
  //         focusedBorder: UnderlineInputBorder(
  //             borderSide: BorderSide(color: AppColors.animationGreenColor)),
  //         enabledBorder: UnderlineInputBorder(
  //             borderSide: BorderSide(color: AppColors.animationBlueColor)),
  //         contentPadding: const EdgeInsets.only(bottom: 3),
  //         labelText: labelText,
  //         labelStyle: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             color: AppColors.animationBlueColor),
  //         floatingLabelBehavior: FloatingLabelBehavior.always,
  //         hintText: placeholder,
  //         hintStyle: TextStyle(
  //           color: AppColors.animationBlueColor,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:masked_text_field/masked_text_field.dart';

// import '../../utils/colors.dart';
// import 'ground_owner_app.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class TimeSlot {
//   final DateTime date;
//   final String time;

//   TimeSlot({required this.date, required this.time});
// }

// class MyGround extends StatefulWidget {
//   const MyGround({Key? key}) : super(key: key);

//   @override
//   _MyGroundState createState() => _MyGroundState();
// }

// class _MyGroundState extends State<MyGround> {
//   final List<TimeSlot> _timeSlots = [];
//   final List<XFile> _selectedImages = [];
//   final ImagePicker _picker = ImagePicker();
//   DateTime _selectedDate = DateTime.now();
//   TimeOfDay _selectedStartTime = TimeOfDay.now();
//   TimeOfDay _selectedEndTime = TimeOfDay.now();
//   List<Map<String, dynamic>> _timeList = [];

//   void _addTimeToList() {
//     Map<String, dynamic> newTime = {
//       'date': _selectedDate,
//       'start_time': _selectedStartTime,
//       'end_time': _selectedEndTime,
//     };
//     setState(() {
//       _timeList.add(newTime);
//     });
//   }

//   Future<void> _selectImage() async {
//     final List<XFile>? result = await _picker.pickMultiImage(imageQuality: 50);
//     if (result != null) {
//       setState(() {
//         _selectedImages.addAll(result);
//       });
//     }
//   }

//   void _deleteImage(int index) {
//     setState(() {
//       _selectedImages.removeAt(index);
//     });
//   }

//   void _saveImages() {
//     // Save the selected images
//   }

//   // DateTime _selectedDate = DateTime.now();
//   String _selectedTime = '';
//   final TextEditingController _timeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.animationBlueColor,
//         title: Text(
//           "Sportswing",
//           style: TextStyle(
//               color: AppColors.whiteColor, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           MaterialButton(
//             onPressed: () => {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const GroundOwnerApp()),
//               )
//             },
//             color: AppColors.animationGreenColor,
//             child: Center(
//                 child: Text(
//               "Save",
//               style: TextStyle(color: AppColors.whiteColor),
//             )),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Select a date:',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.animationBlueColor),
//             ),
//             //-------------------------------------------------------------
//             SizedBox(height: 8),
//             GestureDetector(
//               onTap: () async {
//                 DateTime? newDate = await showDatePicker(
//                   context: context,
//                   initialDate: _selectedDate,
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime.now().add(Duration(days: 365)),
//                 );
//                 if (newDate != null) {
//                   setState(() {
//                     _selectedDate = newDate;
//                   });
//                 }
//               },
//               child: Row(
//                 children: [
//                   Text(
//                     '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Icon(Icons.calendar_today),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Select Start Time:',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             GestureDetector(
//               onTap: () async {
//                 TimeOfDay? newTime = await showTimePicker(
//                   context: context,
//                   initialTime: _selectedStartTime,
//                 );
//                 if (newTime != null) {
//                   setState(() {
//                     _selectedStartTime = newTime;
//                   });
//                 }
//               },
//               child: Row(
//                 children: [
//                   Text(
//                     '${_selectedStartTime.hour}:${_selectedStartTime.minute}',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Icon(Icons.access_time),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Select End Time:',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             GestureDetector(
//               onTap: () async {
//                 TimeOfDay? newTime = await showTimePicker(
//                   context: context,
//                   initialTime: _selectedEndTime,
//                 );
//                 if (newTime != null) {
//                   setState(() {
//                     _selectedEndTime = newTime;
//                   });
//                 }
//               },
//               child: Row(
//                 children: [
//                   Text(
//                     '${_selectedEndTime.hour}:${_selectedEndTime.minute}',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Icon(Icons.access_time),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Time slots',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: AppColors.animationBlueColor,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all<Color>(
//                           AppColors.animationBlueColor)),
//                   onPressed: _addTimeToList,
//                   child: Text('Add Time'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: _timeList.isEmpty
//                   ? Text('No time slots added')
//                   : ListView.builder(
//                       itemCount: _timeList.length,
//                       itemBuilder: (context, index) {
//                         Map<String, dynamic> time = _timeList[index];
//                         // final timeSlot = _timeSlots[index];
//                         // if (time.date == _selectedDate) {
//                         return Card(
//                           child: ListTile(
//                             title: Text(
//                               '${time['date'].day}/${time['date'].month}/${time['date'].year}',
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Start Time: ${time['start_time'].hour}:${time['start_time'].minute}',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 Text(
//                                   'End Time: ${time['end_time'].hour}:${time['end_time'].minute}',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             trailing: IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () {
//                                 setState(() {
//                                   _timeList.removeAt(index);
//                                 });
//                               },
//                             ),
//                           ),
//                         );
//                         // } else {
//                         //   return SizedBox.shrink();
//                         // }
//                       },
//                     ),
//             ),
//             SizedBox(
//               height: 7,
//             ),
//             Divider(
//               thickness: 1.0,
//               color: AppColors.animationBlueColor.withOpacity(0.08),
//               height: 32.0,
//             ),
//             // Ground Fees
//             buildTextField("Ground Fees", "Type grounds fees /hr"),
//             // Description
//             buildTextField("Description", "Type grounds description"),
//             // Location
//             buildTextField("Location", "Type grounds location"),
//             // Upload Images
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Selected Images:',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.animationBlueColor),
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all<Color>(
//                           AppColors.animationBlueColor)),
//                   onPressed: _selectImage,
//                   child: Text('Select Image'),
//                 ),
//               ],
//             ),

//             SizedBox(height: 16),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                 ),
//                 itemCount: _selectedImages.length,
//                 itemBuilder: (context, index) {
//                   return Stack(
//                     children: [
//                       Image.network(
//                         _selectedImages[index].path,
//                         fit: BoxFit.cover,
//                       ),
//                       Positioned(
//                         top: 0,
//                         right: 0,
//                         child: GestureDetector(
//                           onTap: () => _deleteImage(index),
//                           child: CircleAvatar(
//                             backgroundColor: Colors.red,
//                             radius: 12,
//                             child: Icon(
//                               Icons.close,
//                               color: Colors.white,
//                               size: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             // SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Padding buildTextField(String labelText, String placeholder) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 7, bottom: 7),
//       child: TextField(
//         style: TextStyle(color: AppColors.animationBlueColor),
//         decoration: InputDecoration(
//           focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: AppColors.animationGreenColor)),
//           enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: AppColors.animationBlueColor)),
//           contentPadding: const EdgeInsets.only(bottom: 3),
//           labelText: labelText,
//           labelStyle: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: AppColors.animationBlueColor),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           hintText: placeholder,
//           hintStyle: TextStyle(
//             color: AppColors.animationBlueColor,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }