import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const int groundImagesLimit = 4;
const String trainerLocalImage = "assets/images/trainer1.png";
const String owlImage = "assets/images/blueGC.png";

convertToBase64(image) async {
  Uint8List base64Data = await image!.readAsBytes();
  return "data:image/jpeg;base64,${base64.encode(base64Data)}";
}

TimeOfDay timeConvert(String normTime) {
  int hour;
  int minute;
  String ampm = normTime.substring(normTime.length - 2);
  String result = normTime.substring(0, normTime.indexOf(' '));
  if (ampm == 'AM' && int.parse(result.split(":")[1]) != 12) {
    hour = int.parse(result.split(':')[0]);
    if (hour == 12) hour = 0;
    minute = int.parse(result.split(":")[1]);
  } else {
    hour = int.parse(result.split(':')[0]) - 12;
    if (hour <= 0) {
      hour = 24 + hour;
    }
    minute = int.parse(result.split(":")[1]);
  }
  return TimeOfDay(hour: hour, minute: minute);
}

String compareDates(date) {
  final currentDate =
      DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()));
  final inputDate = DateTime.parse(date);
  if (inputDate.compareTo(currentDate) == 0) {
    print("$inputDate is same as $currentDate");
    return "same";
  } else if (inputDate.compareTo(currentDate) < 0) {
    print("$inputDate is before $currentDate");
    return "before";
  } else {
    print("$inputDate is after $currentDate");
    return "after";
  }
}
