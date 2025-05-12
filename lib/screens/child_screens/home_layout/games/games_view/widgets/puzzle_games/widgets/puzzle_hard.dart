import 'dart:math';
import 'dart:ui' as ui;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/screens/child_screens/home_layout/home_layout.dart';
import '../../../../../../../../core/constants/colors.dart';
import '../../../../../../../../core/widgets/app_router.dart';
import '../../../../../../../../core/widgets/app_text.dart';

class PuzzleHard extends StatefulWidget {
  const PuzzleHard({super.key});

  @override
  State<PuzzleHard> createState() => _PuzzleHardState();
}

class _PuzzleHardState extends State<PuzzleHard> {
  late ConfettiController _confettiController;
  List<ui.Image> imagePieces = [];
  List<int?> topGrid = List.filled(25, null);
  List<int> availablePieces2 = List.generate(25, (i) => i);

  void resetGame() {
    setState(() {
      topGrid = List.filled(25, null);
      availablePieces2 = List.generate(25, (i) => i)..shuffle();
    });
  }

  bool isPuzzleSolved() {
    for (var i = 0; i < topGrid.length; i++) {
      if (topGrid[i] == null) {
        return false;
      }
    }

    List<int> correctOrder = List.generate(25, (i) => i);

    for (int i = 0; i < topGrid.length; i++) {
      if (topGrid[i] != correctOrder[i]) {
        return false;
      }
    }
    return true;
  }

  void handlePuzzleCompletion(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300), () {
      bool solved = isPuzzleSolved();
      print("Solved: $solved");
      print("TopGrid after check: $topGrid");
      if (!solved) {
        setState(() {
          topGrid = List.generate(25, (i) => i);
        });
      } else {
        _startRepeatedConfetti();
        _confettiController.play();
      }

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: AppText(
                text: solved ? '🎉 نجاح!' : '❌ سقوط!',
                size: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              content: AppText(
                text:
                    solved
                        ? 'أحسنت، رتبت جميع الالغاز بشكل صحيح!'
                        : 'للأسف، اللغز غير مرتب بشكل صحيح. سيتم عرض الترتيب الصحيح الآن.',
                size: 14.sp,
                lines: 2,
                fontWeight: FontWeight.bold,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (solved) {
                      AppRouter.pop(context);
                      AppCubit.get(context).changebottomNavIndex(1);
                      AppRouter.navigateAndFinish(context, const HomeLayout());
                    } else {
                      AppRouter.pop(context);
                      resetGame();
                    }
                  },
                  child: AppText(
                    text: solved ? 'الانتقال للعبة اخرى' : 'حاول مرة اخرى',
                    size: 14.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
      );
    });
  }

  @override
  void initState() {
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    super.initState();
    _splitImage();
  }

  void _startRepeatedConfetti() async {
    const int repeatCount = 4;
    for (int i = 0; i < repeatCount; i++) {
      _confettiController.play();
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  Future<void> _splitImage() async {
    final ByteData data = await NetworkAssetBundle(
      Uri.parse(
        'https://i.pinimg.com/736x/0d/81/95/0d819575508867474e3026b7b9220f5f.jpg',
      ),
    ).load('');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    final image = frame.image;

    const int rows = 5;
    const int cols = 5;
    final width = image.width ~/ cols;
    final height = image.height ~/ rows;

    List<ui.Image> pieces = [];
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        final piece = await _cropImage(
          image,
          x * width,
          y * height,
          width,
          height,
        );
        pieces.add(piece);
      }
    }

    List<ui.Image> swappedPieces = List.from(pieces);

    // تبديل الأعمدة الخمسة: 0 <-> 4، 1 <-> 3، 2 يبقى
    for (int row = 0; row < rows; row++) {
      int index0 = row * cols + 0;
      int index4 = row * cols + 4;
      int index1 = row * cols + 1;
      int index3 = row * cols + 3;

      // تبديل العمود 0 مع 4
      var temp = swappedPieces[index0];
      swappedPieces[index0] = swappedPieces[index4];
      swappedPieces[index4] = temp;

      // تبديل العمود 1 مع 3
      temp = swappedPieces[index1];
      swappedPieces[index1] = swappedPieces[index3];
      swappedPieces[index3] = temp;
    }

    setState(() {
      imagePieces = swappedPieces;
      availablePieces2.shuffle();
    });
  }

  Future<ui.Image> _cropImage(ui.Image src, int x, int y, int w, int h) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();
    canvas.drawImageRect(
      src,
      Rect.fromLTWH(x.toDouble(), y.toDouble(), w.toDouble(), h.toDouble()),
      Rect.fromLTWH(0, 0, w.toDouble(), h.toDouble()),
      paint,
    );
    final picture = recorder.endRecording();
    return await picture.toImage(w, h);
  }

  Widget imageWidgetFromUiImage(ui.Image img) {
    return RawImage(image: img, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    if (imagePieces.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xffAAD8FC), Color(0xffFCAADA)],
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'اللغز الصعب',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      int? pieceIndex = topGrid[index];
                      return DragTarget<int>(
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            color: Colors.white,
                            child:
                                pieceIndex != null
                                    ? imageWidgetFromUiImage(
                                      imagePieces[pieceIndex],
                                    )
                                    : Container(color: Colors.grey[300]),
                          );
                        },
                        onAcceptWithDetails: (draggedIndex) {
                          if (topGrid[index] != null)
                            return; // تأكد من أن المكان غير مشغول

                          setState(() {
                            topGrid[index] = draggedIndex.data;
                            availablePieces2.remove(draggedIndex.data);
                          });

                          // تحقق بعد كل حركة إذا كل الخانات ممتلئة
                          if (!topGrid.contains(null)) {
                            handlePuzzleCompletion(
                              context,
                            ); // استخدم الدالة الجديدة
                          }

                          print("TopGrid after move: $topGrid");
                        },
                      );
                    },
                  ),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                    itemCount: availablePieces2.length,
                    itemBuilder: (context, index) {
                      int pieceIndex = availablePieces2[index];
                      return Draggable<int>(
                        data: pieceIndex,
                        feedback: SizedBox(
                          width: 60,
                          height: 60,
                          child: imageWidgetFromUiImage(
                            imagePieces[pieceIndex],
                          ),
                        ),
                        childWhenDragging: Container(color: Colors.transparent),
                        child: imageWidgetFromUiImage(imagePieces[pieceIndex]),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: resetGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                    child: const Text(
                      'إعادة المحاولة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 3,
              emissionFrequency: 0.05,
              numberOfParticles: 300,
              maxBlastForce: 20,
              minBlastForce: 5,
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.purple,
                Colors.orange,
                Colors.pink,
                Colors.teal,
                Colors.yellow,
                Colors.cyan,
                Colors.amber,
                Colors.brown,
                Colors.indigo,
                Colors.lime,
                Colors.deepOrange,
                Colors.deepPurple,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
