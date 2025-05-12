import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/screens/child_screens/home_layout/games/games_view/widgets/puzzle_games/widgets/puzzle_hard.dart';

import '../../../../../../../../core/constants/colors.dart';
import '../../../../../../../../core/widgets/app_router.dart';
import '../../../../../../../../core/widgets/app_text.dart';

class MediumPuzzle extends StatefulWidget {
  const MediumPuzzle({super.key});

  @override
  State<MediumPuzzle> createState() => _MediumPuzzleState();
}

class _MediumPuzzleState extends State<MediumPuzzle> {
  late ConfettiController _confettiController;
  List<ui.Image> imagePieces = [];
  List<int?> topGrid = List.filled(16, null);
  List<int> availablePieces2 = List.generate(16, (i) => i);

  void resetGame() {
    setState(() {
      topGrid = List.filled(16, null);
      availablePieces2 = List.generate(16, (i) => i)..shuffle();
    });
  }

  bool isPuzzleSolved() {
    for (var i = 0; i < topGrid.length; i++) {
      if (topGrid[i] == null) {
        return false;
      }
    }

    List<int> correctOrder = List.generate(16, (i) => i);

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
          topGrid = List.generate(16, (i) => i);
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
                size: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              content: AppText(
                text:
                    solved
                        ? 'أحسنت، رتبت اللغز بشكل صحيح!'
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
                      AppRouter.navigateTo(context, const PuzzleHard());
                    } else {
                      AppRouter.pop(context);
                      resetGame();
                    }
                  },
                  child: AppText(
                    text: solved ? 'انتقال للمستوى الصعب' : 'حاول مرة اخرى',
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
        'https://i.pinimg.com/736x/1e/59/f6/1e59f612816a38d1c19cd526b02a270c.jpg',
      ),
    ).load('');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    final image = frame.image;

    const int rows = 4;
    const int cols = 4;
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

    // تبادل الأعمدة 0 مع 3، و1 مع 2
    for (int row = 0; row < rows; row++) {
      int i0 = row * cols + 0;
      int i1 = row * cols + 1;
      int i2 = row * cols + 2;
      int i3 = row * cols + 3;

      var tmp = pieces[i0];
      pieces[i0] = pieces[i3];
      pieces[i3] = tmp;

      tmp = pieces[i1];
      pieces[i1] = pieces[i2];
      pieces[i2] = tmp;
    }

    setState(() {
      imagePieces = pieces;
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
                    'اللغز المتوسط',
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
                          crossAxisCount: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                    itemCount: 16,
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
                          crossAxisCount: 5,
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
                        fontSize: 16,
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
