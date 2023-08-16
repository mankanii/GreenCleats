import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:green_cleats/apps/PlayersApp/player_app.dart';
import 'package:green_cleats/nav/bottom_nav.dart';
import 'package:green_cleats/utils/colors.dart';

class PaymentSuccess extends StatefulWidget {
  var player_id;

  PaymentSuccess({super.key, required this.player_id});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
      ),
      backgroundColor: AppColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/success.gif'),
            height: 150.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Successfull",
              style: TextStyle(
                  color: AppColors.animationBlueColor, fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            "Your payment was done successfully",
            style: TextStyle(color: Colors.grey[400], fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MaterialButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlayerApp(
                            player_id: widget.player_id,
                            index: 0,
                          )),
                )
              },
              height: 60.0,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: AppColors.animationGreenColor,
              child: Text(
                "OK",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
