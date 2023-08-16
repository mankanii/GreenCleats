import 'package:flutter/material.dart';
import 'package:green_cleats/apps/PlayersApp/More/Events/Event.dart';
import 'package:green_cleats/apps/PlayersApp/More/Events/events_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventPage extends StatelessWidget {
  final Event event;

  EventPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("${event.event_title}"),
        backgroundColor: AppColors.animationBlueColor,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: CachedNetworkImage(
              imageUrl: "${event.pictureURL}",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  "${event.event_title}",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.animationBlueColor),
                ),
                SizedBox(height: 8),
                Text(
                  DateFormat('EEEE, MMM d, yyyy').format(DateTime(1)),
                  style: TextStyle(
                      color: AppColors.animationGreenColor,
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  thickness: 1.0,
                  color: AppColors.animationBlueColor.withOpacity(0.08),
                  height: 32.0,
                ),
                SizedBox(height: 16),
                Text(
                  "${event.event_description}",
                  style: TextStyle(color: AppColors.animationBlueColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
