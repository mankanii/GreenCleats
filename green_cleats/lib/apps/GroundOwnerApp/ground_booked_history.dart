import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/utils/colors.dart';

class GroundBookedPage extends StatefulWidget {
  var groundId;

  GroundBookedPage({super.key, required this.groundId});
  @override
  _GroundBookedPageState createState() => _GroundBookedPageState();
}

class _GroundBookedPageState extends State<GroundBookedPage> {
  List _bookings = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groundBookingHistory(widget.groundId).then((response) {
      setState(() {
        _bookings = json.decode(response.body)["history"];
        print(_bookings);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("Bookings"),
        backgroundColor: AppColors.animationBlueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _bookings.length,
          itemBuilder: (BuildContext context, int index) {
            var booking = _bookings[index];
            return Card(
              color: Colors.white,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ListTile(
                title: Text(
                  booking["date"] ?? "29-04-2023",
                  style: TextStyle(
                      color: AppColors.animationBlueColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    "${booking["playerData"]["name"]}\n${booking["playerData"]["contact_number"]}"),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Booking {
  String date;
  String name;
  String phone;

  Booking(this.date, this.name, this.phone);
}
