import 'package:flutter/material.dart';
import 'package:green_cleats/apps/PlayersApp/groundBooking/payment.dart';
import 'package:green_cleats/utils/colors.dart';

var weekdayName = {
  1: "Monday",
  2: "Tuesday",
  3: "Wednesday",
  4: "Thursday",
  5: "Friday",
  6: "Saturday",
  7: "Sunday"
};

class GroundCheckout extends StatefulWidget {
  var groundData;

  var slotSelected;

  var player_id;

  var player_name;

  var team_id;

  GroundCheckout(
      {super.key,
      required this.groundData,
      required this.slotSelected,
      required this.player_id,
      required this.player_name,
      required this.team_id});

  @override
  State<GroundCheckout> createState() => _GroundCheckoutState();
}

class _GroundCheckoutState extends State<GroundCheckout> {
  @override
  Widget build(BuildContext context) {
    // Saving Slot and Day data in variables
    var slot =
        "${widget.slotSelected['start_time']} - ${widget.slotSelected['end_time']}";
    var day = weekdayName[DateTime.parse(widget.slotSelected['date']).weekday];
    // Saving Slot and Day data in variables
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Text(
            //   "Ground",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            // ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 90.0,
                  height: 90.0,
                  child: Icon(
                    Icons.stadium_outlined,
                    color: AppColors.whiteColor,
                    size: 80,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.animationGreenColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 150.0,
                        child: Text(
                          "${widget.groundData['ground_name']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: AppColors.animationGreenColor),
                        )),
                    Container(
                        width: 150.0,
                        child: Text(
                          "$slot",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.animationBlueColor),
                        )),
                    Container(
                        width: 150.0,
                        child: Text(
                          textAlign: TextAlign.center,
                          "$day",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.animationBlueColor),
                        )),
                  ],
                ),
                Text(
                  "\u20A8 ${widget.groundData['fees']}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.animationBlueColor,
                      fontSize: 20),
                ),
              ],
            ),
            Divider(
              thickness: 1.0,
              color: AppColors.animationGreenColor.withOpacity(0.4),
              height: 32.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                      fontSize: 18),
                ),
                Text(
                  "${widget.player_name}",
                  style: TextStyle(color: AppColors.blackColor, fontSize: 18),
                ),
              ],
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Phone Number",
            //       style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //            olor: AppColors.blackColor,
            //           fontSize: 18),
            //     ),
            //     Text(
            //       "03200242342",
            //       style: TextStyle(color: AppColors.blackColor, fontSize: 18),
            //     ),
            //   ],
            // ),
            Divider(
              thickness: 1.0,
              color: AppColors.animationGreenColor.withOpacity(0.4),
              height: 32.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                      fontSize: 20),
                ),
                Text(
                  "\u20A8 ${widget.groundData['fees']}",
                  style: TextStyle(color: AppColors.blackColor, fontSize: 20),
                ),
              ],
            ),
            Spacer(),
            MaterialButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Payment(
                            bookingFor: "ground",
                            player_id: widget.player_id,
                            groundId: widget.groundData["ground_id"],
                            slotId: widget.slotSelected["_id"],
                            team_id: widget.team_id,
                          )),
                )
              },
              height: 60.0,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: AppColors.animationGreenColor,
              child: Text(
                "PROCEED TO CHECKOUT",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 14.0)
          ],
        ),
      ),
    );
  }
}
