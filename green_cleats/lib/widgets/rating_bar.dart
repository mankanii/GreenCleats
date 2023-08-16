import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:green_cleats/utils/colors.dart';

class RatingBarWidget extends StatefulWidget {
  const RatingBarWidget({super.key});

  @override
  State<RatingBarWidget> createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  double fullRating = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("skill"),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              unratedColor: Colors.grey,
              itemCount: 5,
              itemSize: 30.0,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              updateOnDrag: true,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: AppColors.khakiColor,
              ),
              onRatingUpdate: (ratingvalue) {
                setState(() {
                  fullRating = ratingvalue;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
