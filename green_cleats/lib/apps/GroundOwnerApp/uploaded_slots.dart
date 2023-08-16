import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_cleats/apps/GroundOwnerApp/ground_owner_app.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';
import 'package:intl/intl.dart';

import '../../api/apis.dart';

class TimeSlot {
  final DateTime date;
  final String time;

  TimeSlot({required this.date, required this.time});
}

class UploadedSlots extends StatefulWidget {
  var groundID;

  UploadedSlots({super.key, required this.groundID});

  @override
  State<UploadedSlots> createState() => _UploadedSlotsState();
}

class _UploadedSlotsState extends State<UploadedSlots> {
  // final List<TimeSlot> _timeSlots = [];

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  List timeSlotsForSelectedDate = [];
  List slotsToUpdate = [];
  List slotsToDelete = [];

  // void _addTimeToList() {
  //   Map<String, dynamic> newTime = {
  //     'date': _selectedDate,
  //     'start_time': _selectedStartTime,
  //     'end_time': _selectedEndTime,
  //   };
  //   setState(() {
  //     _timeList.add(newTime);
  //   });
  // }

  // List<Map<String, dynamic>> _getTimeSlotsForSelectedDate() {
  //   return _timeList
  //       .where((time) =>
  //           time['date'].year == _selectedDate.year &&
  //           time['date'].month == _selectedDate.month &&
  //           time['date'].day == _selectedDate.day)
  //       .toList();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSlots(widget.groundID,
            DateFormat('yyyy-MM-dd').format(_selectedDate).toString())
        .then((response) {
      setState(() {
        timeSlotsForSelectedDate = json.decode(response.body)['slots'][0]['bs'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text(
          "Uploaded Slots",
          style: TextStyle(
              color: AppColors.whiteColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              var response = await updateSlot(slotsToUpdate, slotsToDelete);
              if (response.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${json.decode(response.body)['message']}"),
                  duration: const Duration(seconds: 2),
                ));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GroundOwnerApp(
                            groundID: widget.groundID,
                          )),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${json.decode(response.body)['message']}"),
                  duration: const Duration(seconds: 2),
                ));
              }
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Time slots',
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColors.animationBlueColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Tooltip(
                      message: 'Click to view information',
                      child: IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          size: 25,
                          color: AppColors.redColor,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Information'),
                                content: const Text(
                                  '1. Click on the date to view slots based on date.\n\n2. Click on the card to edit.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
                // ElevatedButton(
                //   style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all<Color>(
                //           AppColors.animationBlueColor)),
                //   onPressed: _addTimeToList,
                //   child: const Text('Sample Add Time'),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                              primary: AppColors.animationBlueColor,
                              onPrimary: AppColors.whiteColor,
                              surface: AppColors.whiteColor,
                              onSurface: AppColors.blackColor,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _selectedDate = value;
                          getSlots(
                                  widget.groundID,
                                  DateFormat('yyyy-MM-dd')
                                      .format(_selectedDate)
                                      .toString())
                              .then((response) {
                            setState(() {
                              timeSlotsForSelectedDate =
                                  json.decode(response.body)['slots'][0]['bs'];
                            });
                          });
                        });
                      }
                    });
                  },
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(_selectedDate),
                    style: TextStyle(
                        color: AppColors.animationBlueColor, fontSize: 18),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Selected Date',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: timeSlotsForSelectedDate.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> timeSlot =
                      timeSlotsForSelectedDate[index];
                  return TimeSlotCard(
                    timeSlot: timeSlot,
                    onDelete: () {
                      setState(() {
                        timeSlotsForSelectedDate.remove(timeSlot);
                        slotsToDelete.add(timeSlot);
                      });
                    },
                    onEdit: () async {
                      Map<String, dynamic> time =
                          timeSlotsForSelectedDate[index];
                      Map<String, dynamic> updatedTimeSlot =
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditTimeSlot(timeSlot: time)));
                      setState(() {
                        // print(
                        //     "${timeSlotsForSelectedDate[index]["start_time"] != updatedTimeSlot["start_time"]} && ${timeSlotsForSelectedDate[index]["end_time"] != updatedTimeSlot["end_time"]}");
                        // print(
                        //     "${timeSlotsForSelectedDate[index]['start_time'].runtimeType} != ${updatedTimeSlot['start_time'].runtimeType} && ${timeSlotsForSelectedDate[index]['end_time'].runtimeType} != ${updatedTimeSlot['end_time'].runtimeType}");
                        // print(
                        //     "${timeSlotsForSelectedDate[index]['start_time']} != ${updatedTimeSlot['start_time']} && ${timeSlotsForSelectedDate[index]['end_time']} != ${updatedTimeSlot['end_time']}");
                        if (timeSlotsForSelectedDate[index]["start_time"] !=
                                updatedTimeSlot["start_time"] ||
                            timeSlotsForSelectedDate[index]["end_time"] !=
                                updatedTimeSlot["end_time"]) {
                          slotsToUpdate.remove(timeSlotsForSelectedDate[
                              index]); // Making sure that same slot is not getting repeated in slotsToUpdate
                          slotsToUpdate.add(updatedTimeSlot);

                          timeSlotsForSelectedDate[index] = updatedTimeSlot;
                        }
                        // print("Updated Slots are: $slotsToUpdate");
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeSlotCard extends StatelessWidget {
  final Map<String, dynamic> timeSlot;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TimeSlotCard({
    super.key,
    required this.timeSlot,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          '${timeSlot['start_time']} - ${timeSlot['end_time']}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat('EEEE, dd MMMM yyyy')
              .format(DateTime.parse(timeSlot['date'])),
          style: const TextStyle(fontSize: 16),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: AppColors.redColor,
          ),
          onPressed: onDelete,
        ),
        onTap: onEdit,
      ),
    );
  }
}

class EditTimeSlot extends StatefulWidget {
  final Map<String, dynamic> timeSlot;

  const EditTimeSlot({Key? key, required this.timeSlot}) : super(key: key);

  @override
  _EditTimeSlotState createState() => _EditTimeSlotState();
}

class _EditTimeSlotState extends State<EditTimeSlot> {
  late String slotId;
  late DateTime _selectedDate;
  late TimeOfDay _selectedStartTime;
  late TimeOfDay _selectedEndTime;

  @override
  void initState() {
    super.initState();
    // Initialize the form fields with the passed data
    slotId = widget.timeSlot["_id"];
    _selectedDate = DateTime.parse(widget.timeSlot['date']);
    _selectedStartTime = timeConvert(widget.timeSlot['start_time']);
    _selectedEndTime = timeConvert(widget.timeSlot['end_time']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.animationBlueColor,
        title: const Text('Edit Time Slot'),
        actions: [
          MaterialButton(
            onPressed: () {
              Map<String, dynamic> updatedTimeSlot = {
                '_id': slotId,
                'date': DateFormat("yyyy-MM-dd").format(_selectedDate),
                'start_time': _selectedStartTime
                    .format(context), //.format converts TimeOfDay to String
                'end_time': _selectedEndTime.format(context),
              };
              Navigator.pop(context, updatedTimeSlot);
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Padding(
                  //   padding: EdgeInsets.only(bottom: 8.0),
                  //   child: Text(
                  //     'Date',
                  //     style: TextStyle(fontSize: 16),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () async {
                  //     DateTime? newDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: _selectedDate,
                  //       firstDate: DateTime.now(),
                  //       lastDate: DateTime(2100),
                  //     );
                  //     if (newDate != null) {
                  //       setState(() {
                  //         _selectedDate = newDate;
                  //       });
                  //     }
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 12, horizontal: 16),
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.grey),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         const Icon(Icons.calendar_today),
                  //         const SizedBox(width: 8),
                  //         Text(
                  //           '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  //           style: const TextStyle(fontSize: 16),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Start Time',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      TimeOfDay? newStartTime = await showTimePicker(
                        context: context,
                        initialTime: _selectedStartTime,
                      );
                      if (newStartTime != null) {
                        setState(() {
                          _selectedStartTime = newStartTime;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 8),
                          Text(
                            '${_selectedStartTime.hour}:${_selectedStartTime.minute}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'End Time',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // Show the time picker and update the selected end time
                      TimeOfDay? newEndTime = await showTimePicker(
                        context: context,
                        initialTime: _selectedEndTime,
                      );
                      if (newEndTime != null) {
                        setState(() {
                          _selectedEndTime = newEndTime;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 8),
                          Text(
                            '${_selectedEndTime.hour}:${_selectedEndTime.minute}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.redColor,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Expanded(
                    child: Text(
                      "Make sure to select the right date before pressing 'Save'",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
