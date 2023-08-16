import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:green_cleats/utils/colors.dart';

class ReplyCard extends StatefulWidget {
  var message;

  var date;

  ReplyCard({super.key, required this.message, required this.date});

  @override
  State<ReplyCard> createState() => _ReplyCardState();
}

class _ReplyCardState extends State<ReplyCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: AppColors.backgroundColor.withOpacity(0.9),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, right: 60, left: 10, bottom: 20),
                child: Text(
                  "${widget.message}",
                  style: TextStyle(
                      fontSize: 16, color: AppColors.animationBlueColor),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  "${widget.date}",
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
