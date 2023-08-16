// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:green_cleats/utils/colors.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// late List<CameraDescription> cameras;

// class CameraLayout extends StatefulWidget {
//   const CameraLayout({super.key});

//   @override
//   State<CameraLayout> createState() => _CameraLayoutState();
// }

// class _CameraLayoutState extends State<CameraLayout> {
//   late CameraController _cameraController;
//   late Future<void> cameraValue;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _cameraController = CameraController(cameras[0], ResolutionPreset.high);
//     cameraValue = _cameraController.initialize();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _cameraController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           FutureBuilder(
//             future: cameraValue,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return CameraPreview(_cameraController);
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//           Positioned(
//             bottom: 0.0,
//             child: Container(
//               padding: EdgeInsets.only(top: 5, bottom: 5),
//               color: AppColors.blackColor,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           Icons.flash_off,
//                           color: AppColors.whiteColor,
//                           size: 28,
//                         ),
//                         onPressed: () {},
//                       ),
//                       InkWell(
//                         onTap: () {},
//                         child: Icon(
//                           Icons.panorama_fish_eye,
//                           color: AppColors.whiteColor,
//                           size: 70,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.flip_camera_ios,
//                           size: 28,
//                           color: AppColors.whiteColor,
//                         ),
//                         onPressed: () {},
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 4,
//                   ),
//                   Text(
//                     "Tap for photo",
//                     style: TextStyle(color: AppColors.whiteColor),
//                     textAlign: TextAlign.center,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // void takePhoto() async {
//   //   final path =
//   //       join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
//   //   await _cameraController.takePicture(path);
//   // }
// }
