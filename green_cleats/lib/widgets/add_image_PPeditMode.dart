// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:green_cleats/utils/colors.dart';
// import 'package:image_picker/image_picker.dart';

// class AddImage extends StatefulWidget {
//   const AddImage({super.key});

//   @override
//   State<AddImage> createState() => _AddImageState();
// }

// class _AddImageState extends State<AddImage> {
//   List _images = [];
//   // late File imageFile;
//   final picker = ImagePicker();
//   Future chooseImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         File file = File(pickedFile.path);
//         _images.add(file);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StaggeredGridView.countBuilder(
//       shrinkWrap: true,
//       crossAxisCount: 4,
//       itemCount: _images.length + 1,
//       itemBuilder: (BuildContext context, index) {
//         return index == _images.length
//             ? GestureDetector(
//                 onTap: () {
//                   chooseImage();
//                 },
//                 child: Container(
//                   child: DottedBorder(
//                     color: Colors.grey,
//                     strokeWidth: 2,
//                     radius: Radius.circular(8),
//                     dashPattern: [8, 4],
//                     child: ClipRRect(
//                       child: Container(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: Icon(
//                           Icons.add,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             : Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: AppColors.whiteColor,
//                     image: DecorationImage(
//                         image: FileImage(_images[index]), fit: BoxFit.cover)),
//               );
//       },
//       staggeredTileBuilder: (int index) =>
//           StaggeredTile.count(index == 0 ? 2 : 1, index == 0 ? 2 : 1),
//       mainAxisSpacing: 3,
//       crossAxisSpacing: 3,
//     );
//   }
// }
