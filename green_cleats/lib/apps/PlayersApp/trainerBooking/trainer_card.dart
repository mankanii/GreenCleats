import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';
import 'trainer.dart';
import 'trainer_page.dart';

class TrainerCard extends StatelessWidget {
  final trainer;
  final Function(dynamic) onBook;

  TrainerCard({required this.trainer, required this.onBook});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                        trainer["picture_url"] ?? trainerLocalImage),
                    fit: BoxFit.cover,
                    opacity: 0.9),
              ),
            ),
            Center(
              heightFactor: sqrt2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        trainer["full_name"],
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            backgroundColor:
                                AppColors.blackColor.withOpacity(0.5),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        trainer["profession_category"],
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            backgroundColor:
                                AppColors.animationBlueColor.withOpacity(0.5),
                            fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.animationGreenColor),
                    ),
                    onPressed: () => onBook(trainer),
                    child: const Text('Book Trainer'),
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
