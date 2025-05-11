// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hemtnaa/core/widgets/app_button.dart';
// import 'package:hemtnaa/core/widgets/app_text.dart';
// import 'package:hemtnaa/core/widgets/custom_bottom_nav.dart';
// import 'package:hemtnaa/gen/assets.gen.dart';
// import 'package:image/image.dart' as img;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../core/constants/colors.dart';

// class PuzzleScreen extends StatefulWidget {
//   const PuzzleScreen({super.key});

//   @override
//   PuzzleScreenState createState() => PuzzleScreenState();
// }

// class PuzzleScreenState extends State<PuzzleScreen> {
//   final String imagePath = Assets.img.puzzel2.path;
//   final int rows = 3;
//   final int cols = 3;
//   List<Uint8List> imagePieces = [];
//   List<int> availablePieces = [];
//   Map<int, Uint8List> placedPieces = {};

//   @override
//   void initState() {
//     super.initState();
//     _splitImage();
//   }

//   Future<void> _splitImage() async {
//     final ByteData data = await rootBundle.load(imagePath);
//     final Uint8List bytes = data.buffer.asUint8List();
//     final img.Image? image = img.decodeImage(bytes);

//     if (image != null) {
//       int pieceWidth = (image.width ~/ cols).toInt();
//       int pieceHeight = (image.height ~/ rows).toInt();
//       List<Uint8List> pieces = [];

//       for (int y = 0; y < rows; y++) {
//         for (int x = 0; x < cols; x++) {
//           img.Image cropped = img.copyCrop(
//             image,
//             x: x * pieceWidth,
//             y: y * pieceHeight,
//             width: pieceWidth,
//             height: pieceHeight,
//           );

//           pieces.add(Uint8List.fromList(img.encodePng(cropped)));
//         }
//       }

//       setState(() {
//         imagePieces = pieces..shuffle();
//         availablePieces = List.generate(imagePieces.length, (index) => index);
//         placedPieces.clear();
//       });
//     }
//   }

//   void _resetGame() {
//     setState(() {
//       imagePieces.shuffle();
//       availablePieces = List.generate(imagePieces.length, (index) => index);
//       placedPieces.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       bottomNavigationBar: const CustomBottomNav(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 60.h),
//             Center(
//               child: SizedBox(
//                 width: cols * 100.w,
//                 height: rows * 100.h,
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   padding: EdgeInsets.zero,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: cols,
//                     childAspectRatio: 1,
//                     crossAxisSpacing: 0,
//                     mainAxisSpacing: 0,
//                   ),
//                   itemCount: rows * cols,
//                   itemBuilder: (context, index) {
//                     return DragTarget<int>(
//                       onAcceptWithDetails: (details) {
//                         int draggedIndex = details.data;
//                         setState(() {
//                           if (placedPieces.containsKey(index)) {
//                             availablePieces.add(
//                               imagePieces.indexOf(placedPieces[index]!),
//                             );
//                           }
//                           placedPieces[index] = imagePieces[draggedIndex];
//                           availablePieces.remove(draggedIndex);
//                         });
//                         if (placedPieces.length == rows * cols) {
//                           bool isCorrect = placedPieces.keys.every(
//                             (key) => placedPieces[key] == imagePieces[key],
//                           );
//                           if (isCorrect) {
//                             _showWinDialog();
//                           }
//                         }
//                       },

//                       builder: (context, candidateData, rejectedData) {
//                         return Container(
//                           width: 100.w,
//                           height: 100.w,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 1.w),
//                           ),
//                           child:
//                               placedPieces.containsKey(index)
//                                   ? Image.memory(
//                                     placedPieces[index]!,
//                                     width: 100.w,
//                                     height: 100.w,
//                                     fit: BoxFit.cover,
//                                   )
//                                   : const SizedBox.shrink(),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 18.h),
//             Wrap(
//               spacing: 4,
//               runSpacing: 4,
//               children:
//                   availablePieces.map((index) {
//                     return Draggable<int>(
//                       data: index,
//                       feedback: Image.memory(
//                         imagePieces[index],
//                         width: 100.w,
//                         height: 100.w,
//                         fit: BoxFit.cover,
//                       ),
//                       childWhenDragging: Opacity(
//                         opacity: 0.5,
//                         child: Image.memory(
//                           imagePieces[index],
//                           width: 100.w,
//                           height: 100.w,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       child: Image.memory(
//                         imagePieces[index],
//                         width: 100.w,
//                         height: 100.w,
//                         fit: BoxFit.cover,
//                       ),
//                     );
//                   }).toList(),
//             ),
//             SizedBox(height: 20.h),
//             AppButton(
//               onPressed: _resetGame,
//               width: 120.w,
//               child: Row(
//                 children: [
//                   SizedBox(width: 5.w),
//                   const Icon(Icons.repeat, color: Colors.white),
//                   AppText(
//                     text: "إعادة اللعبة",
//                     size: 18.sp,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.h),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showWinDialog() {
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: AppText(
//               text: "مبروك!",
//               size: 20.sp,
//               color: AppColors.primary,
//             ),
//             content: AppText(
//               text: "لقد أكملت اللغز بنجاح!",
//               size: 20.sp,
//               color: AppColors.primary,
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   _resetGame();
//                 },
//                 child: AppText(
//                   text: "إعادة اللعب",
//                   size: 20.sp,
//                   color: AppColors.primary,
//                 ),
//               ),
//             ],
//           ),
//     );
//   }
// }
