import 'dart:math';
import 'dart:ui' as ui;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EasyPuzzle extends StatefulWidget {
  const EasyPuzzle({super.key});

  @override
  State<EasyPuzzle> createState() => _EasyPuzzleState();
}

class _EasyPuzzleState extends State<EasyPuzzle> {
  late ConfettiController _confettiController;
  List<ui.Image> imagePieces = [];
  List<int?> topGrid = List.filled(9, null); // حفظ الإندكس للقطعة
  List<int> availablePieces = List.generate(9, (i) => i);

  void resetGame() {
    setState(() {
      topGrid = List.filled(9, null);
      availablePieces = List.generate(9, (i) => i)..shuffle();
    });
  }

  bool isPuzzleSolved() {
    for (var i = 0; i < topGrid.length; i++) {
      if (topGrid[i] == null) {
        return false;
      }
    }

    List<int> correctOrder = List.generate(9, (i) => i);

    for (int i = 0; i < topGrid.length; i++) {
      if (topGrid[i] != correctOrder[i]) {
        return false;
      }
    }
    return true;
  }

  // تعديل طريقة onAcceptWithDetails بحيث في حالة السقوط، يعرض الترتيب الصحيح
  void handlePuzzleCompletion(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300), () {
      bool solved = isPuzzleSolved();
      print("Solved: $solved");
      print("TopGrid after check: $topGrid");
      if (!solved) {
        setState(() {
          topGrid = List.generate(9, (i) => i); // ضبط القطع في الترتيب الصحيح
        });
      } else {
        _confettiController.play(); // 🎈 شغل البالونات عند النجاح
      }

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text(solved ? '🎉 نجاح!' : '❌ سقوط!'),
              content: Text(
                solved
                    ? 'أحسنت، رتبت اللغز بشكل صحيح!'
                    : 'للأسف، اللغز غير مرتب بشكل صحيح. سيتم عرض الترتيب الصحيح الآن.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame();
                  },
                  child: const Text('إعادة المحاولة'),
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

  Future<void> _splitImage() async {
    final ByteData data = await NetworkAssetBundle(
      Uri.parse(
        'https://i.pinimg.com/736x/23/65/59/2365594fab2f5b46de174361620f13b5.jpg',
      ),
    ).load('');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    final image = frame.image;

    const int rows = 3;
    const int cols = 3;
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
        pieces.add(piece); // القطع تُحفظ حسب الترتيب الصحيح
      }
    }
    List<ui.Image> swapColumns(
      List<ui.Image> pieces,
      int rowCount,
      int colCount,
    ) {
      List<ui.Image> fixed = List.from(pieces);
      for (int row = 0; row < rowCount; row++) {
        int start = row * colCount;
        int left = start; // العمود 0
        int right = start + 2; // العمود 2

        var temp = fixed[left];
        fixed[left] = fixed[right];
        fixed[right] = temp;
      }
      return fixed;
    }

    setState(() {
      imagePieces = swapColumns(pieces, rows, cols); // تم تبديل الأعمدة
      availablePieces.shuffle();
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
                    'اللغز السهل',
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
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                    itemCount: 9,
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
                            availablePieces.remove(draggedIndex.data);
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
                    itemCount: availablePieces.length,
                    itemBuilder: (context, index) {
                      int pieceIndex = availablePieces[index];
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
              blastDirection: pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 30,
              maxBlastForce: 20,
              minBlastForce: 5,
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.purple,
                Colors.orange,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
