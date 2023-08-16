import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../apps/PlayersApp/More/Events/Event.dart';

String url = "http://localhost:3000";
// String url = "http://10.0.2.2:3000";

// Register API's
registerTrainer(
  fullName,
  emailAddress,
  contactNumber,
  dateOfBirth,
  professionCategory,
  gender,
) async {
  var response = await http.post(Uri.parse("$url/registerTrainer"), body: {
    "full_name": fullName,
    "email_address": emailAddress,
    "contact_number": contactNumber,
    "date_of_birth": dateOfBirth,
    "profession_category": professionCategory,
    "gender": gender,
  });
  return response;
}
// Register API's

//Start Player App API's
// Events API
Future<List<Event>> fetchEvents() async {
  final response = await http.get(Uri.parse('$url/viewEvents'));

  if (response.statusCode == 200) {
    final List result = json.decode(response.body)["events"];
    return result.map((e) => Event.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

Future bookingHistory(teamId) async {
  try {
    var response = await http.get(Uri.parse("$url/booking_history/$teamId"));
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception(json.decode(response.body)["message"]);
    }
  } catch (e) {
    throw Exception("Failed to load data ~ Check your Internet Connection $e");
  }
}

Future trainersData() async {
  var response = await http.get(Uri.parse("$url/viewAllTrainer"));
  return response;
}

//End Player App API's

//Start Ground App API's
// Fetch Grounds
Future getGrounds() async {
  final response = await http.get(Uri.parse("$url/viewGrounds"));
  if (response.statusCode == 200) {
    final grounds = json.decode(response.body)["grounds"];
    return grounds;
  } else {
    throw Exception('Failed to load data of grounds');
  }
}

Future getGroundsImages(groundId) async {
  final response = await http.get(Uri.parse("$url/groundImages/$groundId"));
  if (response.statusCode == 200) {
    final images = json.decode(response.body)["images"];
    return images;
  } else {
    throw Exception('Failed to load data of grounds');
  }
}

Future deleteGroundsImage(imageId, imagePublicId) async {
  final response = await http.post(Uri.parse("$url/deleteGroundImage"), body: {
    "imageId": imageId,
    "image_public_id": imagePublicId,
  });
  return response;
}

// Add Slots of Grounds API
Future addSlot(slots, groundID) async {
  var response = await http.post(Uri.parse("$url/addSlot/$groundID"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "slots": slots,
      }));
  return response;
}

// Get Ground Slots
Future getSlots(groundId, date) async {
  try {
    var response = await http.get(Uri.parse("$url/getSlots/$groundId/$date"));
    if (response.statusCode == 200) {
      // var slots = json.decode(response.body)["slots"];
      return response;
    } else {
      throw Exception(json.decode(response.body)["error"]);
    }
  } catch (e) {
    throw Exception("Failed to load data ~ Check your Internet Connection");
  }
}

Future checkSlot(slotID) async {
  var response = await http.post(
    Uri.parse("$url/checkSlot/$slotID"),
  );
  return response;
}

Future bookSlot(slotId, groundId, teamId, playerId, paymentMethod) async {
  var response = await http.post(Uri.parse("$url/bookSlot"), body: {
    "slot_id": slotId,
    "ground_id": groundId,
    "team_id": teamId,
    "player_id": playerId,
    "payment_method": paymentMethod,
  });
  return response;
}

Future updateSlot(slotsToUpdate, slotsToDelete) async {
  var response = await http.post(Uri.parse("$url/updateSlot"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "slotsToUpdate": slotsToUpdate,
        "slotsToDelete": slotsToDelete,
      }));
  return response;
}

Future uploadGroundImages(groundId, images) async {
  var response = await http.post(Uri.parse("$url/uploadGroundImages"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "groundId": groundId,
        "images": images,
      }));
  return response;
}

// Update Ground
Future updateGround(
    groundName, groundFees, groundDescription, location, groundID) async {
  var response = await http.post(Uri.parse("$url/updateGround/$groundID"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "ground_name": groundName,
        "ground_fees": groundFees,
        "ground_description": groundDescription,
        "location": location,
      }));
  return response;
}

Future groundBookingHistory(groundId) async {
  try {
    var response =
        await http.get(Uri.parse("$url/groundBookingHistory/$groundId"));
    return response;
  } catch (e) {
    throw Exception("Failed To Load Data. Check your Internet Connection");
  }
}

//End Ground App API's

//Start Trainer App API's

Future trainerData(trainerId) async {
  try {
    var response = await http.get(Uri.parse("$url/trainer/$trainerId"));
    return response;
  } catch (e) {
    throw Exception("Failed To Load Data. Check your Internet Connection");
  }
}

Future trainerBookingHistory(trainerId) async {
  try {
    var response =
        await http.get(Uri.parse("$url/trainerBookingHistory/$trainerId"));
    return response;
  } catch (e) {
    throw Exception("Failed To Load Data. Check your Internet Connection");
  }
}

Future updateTrainer(
    trainerId, fullName, contactNumber, description, location) async {
  var response = await http.post(Uri.parse("$url/updateTrainer"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "trainerId": trainerId,
        "full_name": fullName,
        "contact_number": contactNumber,
        "description": description,
        "location": location,
      }));
  return response;
}

Future uploadTrainerImage(trainerId, image, imagePublicId) async {
  var response = await http.post(Uri.parse("$url/uploadTrainerImage"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "trainerId": trainerId,
        "image": image,
        "image_public_id": imagePublicId,
      }));
  return response;
}

Future addTrainerPackages(packages) async {
  try {
    var response = await http.post(Uri.parse("$url/trainerPackages"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "packages": packages,
        }));
    return response;
  } catch (e) {
    throw Exception(
        "Error Occurred $e ~ Please check your internet connection");
  }
}

Future getTrainerPackages(trainerId) async {
  try {
    var response = await http.get(
      Uri.parse("$url/trainerPackages/$trainerId"),
    );
    return response;
  } catch (e) {
    throw Exception(
        "Error Occurred $e ~ Please check your internet connection");
  }
}

Future bookPackage(
    packageId, trainerId, playerId, paymentMethod, paymentDetails) async {
  var response = await http.post(Uri.parse("$url/bookPackage"), body: {
    "package_id": packageId,
    "trainer_id": trainerId,
    "player_id": playerId,
    "payment_method": paymentMethod,
    "payment_details": paymentDetails,
    "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
  });
  return response;
}

Future trainerHired(playerId) async {
  try {
    var response = await http.get(
      Uri.parse("$url/trainerHired/$playerId"),
    );
    return response;
  } catch (e) {
    throw Exception(
        "Error Occurred $e ~ Please check your internet connection");
  }
}

//End Trainer App API's

// Other API's
Future changePassword(userId, currentPassword, newPassword) async {
  var response = await http.post(Uri.parse("$url/changePassword"), body: {
    "id": userId,
    "current_password": currentPassword,
    "new_password": newPassword,
  });
  return response;
}
// Other API's

Future uploadPost(data, image, owner_id) async {
  var response = await http.post(Uri.parse("$url/postingPage"), body: {
    "data": data,
    "image": image,
    "owner_id": owner_id,
  });
  return json.decode(response.body);
}

Future fetchposts() async {
  try {
    var response = await http.get(
      Uri.parse("$url/postingPage"),
    );
    return response;
  } catch (e) {
    throw Exception(
        "Error Occurred $e ~ Please check your internet connection");
  }
}

Future getMessages(ownEmail, otherEmail) async {
  try {
    var response =
        await http.get(Uri.parse("$url/getMessages/$ownEmail/$otherEmail"));
    return json.decode(response.body);
  } catch (e) {
    throw Exception(
        "Error Occurred $e ~ Please check your internet connection");
  }
}

Future sendMessage(sender_id, receiver_id, message) async {
  try {
    var response = await http.post(Uri.parse("$url/sendMessage"), body: {
      "sender_id": sender_id,
      "receiver_id": receiver_id,
      "message_content": message
    });
    return response;
  } catch (e) {
    throw Exception(
        "Error Occurred $e ~ Please check your internet connection");
  }
}

Future getMessagedPlayers(email) async {
  var response = await http.get(Uri.parse("$url/messagedPlayers/$email"));
  return json.decode(response.body);
}
