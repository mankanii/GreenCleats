// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:green_cleats/utils/colors.dart';

// class GenderWidget extends StatefulWidget {
//   var value;

//   GenderWidget({super.key, required this.value});

//   @override
//   State<GenderWidget> createState() => GenderWidgetState();
// }

// class GenderWidgetState extends State<GenderWidget> {
//   List<String> genders = ["Male", "Female", "Other"];
//   List<bool> isSelected = [true, false, false];
//   @override
//   Widget build(BuildContext context) {
//     return ToggleButtons(
//       isSelected: isSelected,
//       borderRadius: BorderRadius.circular(10),
//       color: AppColors.whiteColor,
//       fillColor: AppColors.animationGreenColor,
//       selectedColor: AppColors.whiteColor,
//       splashColor: AppColors.animationGreenColor,
//       children: const <Widget>[
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text("Male"),
//         ),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text("Female"),
//         ),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text("Other"),
//         ),
//       ],
//       onPressed: (int newIndex) {
//         setState(() {
//           for (int index = 0; index < isSelected.length; index++) {
//             if (index == newIndex) {
//               isSelected[index] = true;
//               widget.value = genders[index];
//             } else {
//               isSelected[index] = false;
//             }
//           }
//         });
//       },
//     );
//   }
// }
