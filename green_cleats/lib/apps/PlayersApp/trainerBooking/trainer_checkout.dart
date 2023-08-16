import 'package:flutter/material.dart';
import 'package:green_cleats/apps/PlayersApp/groundBooking/payment.dart';
import 'package:green_cleats/utils/colors.dart';

class TrainerCheckout extends StatefulWidget {
  var trainerCategory;

  var trainerContactNumber;

  var trainerName;

  var packageName;

  var packagePrice;

  var player_id;

  var trainer_id;
  
  var packageId;

  TrainerCheckout(
      {super.key,
      required this.player_id,
      required this.trainer_id,
      required this.packageId,
      required this.packageName,
      required this.packagePrice,
      required this.trainerName,
      required this.trainerCategory,
      required this.trainerContactNumber});

  @override
  State<TrainerCheckout> createState() => _TrainerCheckoutState();
}

class _TrainerCheckoutState extends State<TrainerCheckout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
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
                    Icons.sports_gymnastics_rounded,
                    color: AppColors.whiteColor,
                    size: 80,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.animationBlueColor,
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
                          "${widget.packageName}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: AppColors.animationBlueColor),
                        )),
                    Container(
                        width: 150.0,
                        child: Text(
                          "${widget.trainerCategory}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.animationGreenColor),
                        )),
                    Container(
                        width: 150.0,
                        child: Text(
                          textAlign: TextAlign.center,
                          "${widget.trainerName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.animationGreenColor),
                        )),
                  ],
                ),
                Text(
                  "${widget.packagePrice}",
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
                  "${widget.trainerName}",
                  style: TextStyle(color: AppColors.blackColor, fontSize: 18),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone Number",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                      fontSize: 18),
                ),
                Text(
                  "${widget.trainerContactNumber}",
                  style: TextStyle(color: AppColors.blackColor, fontSize: 18),
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
                  "Total",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                      fontSize: 20),
                ),
                Text(
                  "${widget.packagePrice}",
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
                            bookingFor: "trainer",
                            player_id: widget.player_id,
                            trainerId: widget.trainer_id,
                            packageId: widget.packageId,
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
