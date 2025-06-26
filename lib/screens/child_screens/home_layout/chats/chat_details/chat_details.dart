import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chewie/chewie.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/widgets/app_input.dart';
import 'package:hemtnaa/gen/assets.gen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import 'widgets/chat_header.dart';

class ChatDetails extends StatefulWidget {
  const ChatDetails({super.key});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  String? _recordedAudioPath;
  bool isRecording = false;
  bool showSend = false;
  bool showEmojiPicker = false;
  double _inputHeight = 50.h;
  final TextEditingController _messageSendController = TextEditingController();
  final RecorderController _recorderController = RecorderController();
  final List<ChatMessage> messages = [];
  int _recordDuration = 0;
  Timer? _recordTimer;
  late AnimationController _controller;

  Future<void> requestMicPermission() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      throw Exception("Microphone permission not granted");
    }
  }

  Future<void> _startRecording() async {
    await requestMicPermission();
    final dir = await getApplicationDocumentsDirectory();
    final path =
        '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

    _recorderController.reset();
    _recorderController.record(path: path);

    setState(() {
      isRecording = true;
    });

    _recordedAudioPath = path;
    _startRecordingTimer();
  }

  Future<void> _stopRecordingAndSend() async {
    await _recorderController.stop();

    setState(() {
      isRecording = false;
    });

    if (_recordedAudioPath != null) {
      debugPrint('🎤 تم تسجيل الصوت: $_recordedAudioPath');

      final playerController = PlayerController();

      await playerController.preparePlayer(
        path: _recordedAudioPath!,
        shouldExtractWaveform: true,
      );

      // فقط لتحديث الأيقونة عند الانتهاء
      playerController.onPlayerStateChanged.listen((_) {
        setState(() {});
      });

      setState(() {
        messages.add(
          ChatMessage(
            type: MessageType.audio,
            content: _recordedAudioPath!,
            isSender: true,
            playerController: playerController,
          ),
        );
      });
      _stopRecordingTimer();
    }
  }

  void _startRecordingTimer() {
    _recordDuration = 0;
    _recordTimer?.cancel();
    _recordTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _recordDuration++;
      setState(() {}); // لتحديث الوقت في الواجهة
    });
  }

  void _stopRecordingTimer() {
    _recordTimer?.cancel();
    _recordTimer = null;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    _messageSendController.addListener(() {
      setState(() {
        showSend = _messageSendController.text.trim().isNotEmpty;
      });
    });
    _messageSendController.addListener(_adjustInputHeight);
    _loadSavedBackground();
  }

  void _adjustInputHeight() {
    final lineCount = '\n'.allMatches(_messageSendController.text).length + 1;

    setState(() {
      _inputHeight = 50 + ((lineCount - 1) * 24);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0.0) {
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final text = _messageSendController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(
          ChatMessage(type: MessageType.text, content: text, isSender: true),
        );
      });
      _messageSendController.clear();
      _scrollToBottom();
    }
  }

  Future<void> _pickAndSendImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      File imageFile = File(image.path);

      _sendImage(imageFile);
    }
  }

  void _sendImage(File imageFile) {
    setState(() {
      messages.add(
        ChatMessage(
          type: MessageType.image,
          content: imageFile.path,
          isSender: true,
        ),
      );
    });
    _scrollToBottom();
  }

  Future<void> _pickAndSendFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);

      _sendFile(file);
    }
  }

  void _sendFile(File file) {
    setState(() {
      messages.add(
        ChatMessage(type: MessageType.file, content: file.path, isSender: true),
      );
    });
    _scrollToBottom();
  }

  File? _chatBackground;

  Future<void> _pickBackgroundImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final dir = Directory(appDir.path);
      await for (var file in dir.list()) {
        if (file.path.contains('chat_background_')) {
          await file.delete();
        }
      }
      final savedImage = await File(picked.path).copy(
        '${appDir.path}/chat_background_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('chat_background', savedImage.path);

      setState(() {
        _chatBackground = savedImage;
      });
    }
  }

  Future<void> _loadSavedBackground() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString('chat_background');

    if (File(path!).existsSync()) {
      setState(() {
        _chatBackground = File(path);
      });
    }
  }

  Future<void> _pickAndSendImagesFromGallery() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    for (var image in images) {
      _sendImage(File(image.path));
    }
  }

  Future<void> _pickAndSendVideos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );

    if (result != null) {
      for (var file in result.files) {
        if (file.path != null) {
          _sendVideo(File(file.path!));
        }
      }
    }
  }

  void _sendVideo(File videoFile) {
    setState(() {
      messages.add(
        ChatMessage(
          type: MessageType.video,
          content: videoFile.path,
          isSender: true,
        ),
      );
    });
    _scrollToBottom();
  }

  void showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                  _pickAndSendImageFromCamera();
                },
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        spreadRadius: 1.r,
                        blurRadius: 5.r,
                        offset: Offset(0, 5.r),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 35.w,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.2),
                              spreadRadius: 1.r,
                              blurRadius: 5.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      AppText(
                        text: 'تصوير بالكاميرا',
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.pop(context);
                  await _pickAndSendImagesFromGallery();
                },
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        spreadRadius: 1.r,
                        blurRadius: 5.r,
                        offset: Offset(0, 5.r),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 35.w,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.2),
                              spreadRadius: 1.r,
                              blurRadius: 5.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      AppText(
                        text: 'اختيار صور من المعرض',
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.pop(context);
                  await _pickAndSendVideos();
                },
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        spreadRadius: 1.r,
                        blurRadius: 5.r,
                        offset: Offset(0, 5.r),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 35.w,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.2),
                              spreadRadius: 1.r,
                              blurRadius: 5.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.videocam,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      AppText(
                        text: 'إرسال فيديو',
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.pop(context);
                  await _pickAndSendFile();
                },
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        spreadRadius: 1.r,
                        blurRadius: 5.r,
                        offset: Offset(0, 5.r),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 35.w,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.2),
                              spreadRadius: 1.r,
                              blurRadius: 5.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.attach_file,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      AppText(
                        text: 'إرسال ملف',
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    switch (message.type) {
      case MessageType.text:
        return _textBubble(message.content, message.isSender);
      case MessageType.image:
        return _imageBubble(message.content);
      case MessageType.video:
        return _videoBubble(message.content);
      case MessageType.audio:
        return _audioBubble(message);
      case MessageType.file:
        return _fileBubble(message.content);
    }
  }

  Widget _textBubble(String text, bool isSender) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isSender ? AppColors.primary : const Color(0xffD7E4F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSender ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _imageBubble(String path) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenImageView(imagePath: path),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.file(
          File(path),
          width: 200.w,
          height: 200.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _videoBubble(String path) {
    return FutureBuilder<String?>(
      future: _generateThumbnail(path),
      builder: (context, snapshot) {
        final thumbnailPath = snapshot.data;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => VideoViewerScreen(path: path)),
            );
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder:
                (context, child) => Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1 + 2 * _controller.value, -1),
                      end: Alignment(1 - 2 * _controller.value, 1),
                      colors: const [
                        AppColors.primary,
                        Colors.black,
                        AppColors.primary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    image:
                        thumbnailPath != null
                            ? DecorationImage(
                              image: FileImage(File(thumbnailPath)),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      thumbnailPath == null
                          ? const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.play_circle_fill,
                              size: 48,
                              color: Colors.white,
                            ),
                          )
                          : const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.play_circle_fill,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                ),
          ),
        );
      },
    );
  }

  Future<String?> _generateThumbnail(String videoPath) async {
    final tempDir = await getTemporaryDirectory();
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath:
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg',
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 75,
    );
    return thumbnailPath;
  }

  Widget _audioBubble(ChatMessage message) {
    final controller = message.playerController!;

    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  if (controller.playerState == PlayerState.playing) {
                    await controller.stopPlayer();
                  } else {
                    await controller.startPlayer();
                  }
                  // تحديث واجهة المستخدم
                  setState(() {});
                },
                child: Icon(
                  controller.playerState == PlayerState.playing
                      ? Icons.stop
                      : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              AudioFileWaveforms(
                size: Size(150.w, 40.h),
                playerController: controller,
                enableSeekGesture: true,
                waveformType: WaveformType.fitWidth,
                playerWaveStyle: const PlayerWaveStyle(
                  fixedWaveColor: Colors.white,
                  liveWaveColor: Colors.white70,
                  spacing: 6,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              _formatDuration(controller.maxDuration),
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fileBubble(String path) {
    final fileName = path.split('/').last;

    return GestureDetector(
      onTap: () async {
        final result = await OpenFile.open(path);
        debugPrint("📂 تم فتح الملف: ${result.message}");
      },
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.insert_drive_file, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              fileName,
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else if (minutes > 0) {
      return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '00:${secs.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              _chatBackground != null
                  ? Image.file(
                    _chatBackground!,
                    key: ValueKey(_chatBackground!.path),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                  : Image.asset(
                    Assets.img.doctor.path,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChatHeader(onChangeBackground: _pickBackgroundImage),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(bottom: 100.h),
                      itemCount: messages.isEmpty ? 0 : messages.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final message = messages[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 6.h,
                          ),
                          child: Align(
                            alignment:
                                message.isSender
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: _buildMessageBubble(message),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 6.h,
                    ),
                    child: Row(
                      children: [
                        if (!showSend)
                          GestureDetector(
                            onLongPress: () async {
                              await _startRecording();
                            },
                            onLongPressUp: () async {
                              await _stopRecordingAndSend();
                            },
                            child: Container(
                              height: 50.w,
                              width: 50.w,
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  isRecording ? Icons.stop : Icons.mic,
                                  color: Colors.white,
                                  size: 30.sp,
                                ),
                              ),
                            ),
                          ),
                        if (showSend)
                          GestureDetector(
                            onTap: () {
                              _sendMessage();
                              _messageSendController.clear();
                            },
                            child: Container(
                              height: 50.w,
                              width: 50.w,
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Transform.scale(
                                  scaleX: -1,
                                  child: Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                    size: 26.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child:
                              isRecording
                                  ? Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AudioWaveforms(
                                          enableGesture: false,
                                          size: Size(double.infinity, 50.h),
                                          backgroundColor: Colors.white,
                                          recorderController:
                                              _recorderController,
                                          waveStyle: const WaveStyle(
                                            waveColor: AppColors.primary,
                                            extendWaveform: true,
                                            showMiddleLine: false,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          _formatDuration(_recordDuration),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : SizedBox(
                                    height: _inputHeight,
                                    child: AppInput(
                                      textInputAction: TextInputAction.newline,
                                      start: 0,
                                      end: 0,
                                      onTap: () {
                                        if (showEmojiPicker) {
                                          setState(() {
                                            showEmojiPicker = false;
                                          });
                                        }
                                      },
                                      controller: _messageSendController,
                                      enabledBorderColor: Colors.grey,
                                      inputType: TextInputType.multiline,
                                      maxLines: 100,
                                      filled: true,
                                      hint: 'اكتب رسالة',
                                      prefixIcon: SizedBox(
                                        width: 80.w,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.bottomStart,
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(
                                              start: 8.w,
                                              bottom: 12.h,
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 8.w),
                                                GestureDetector(
                                                  onTap:
                                                      _pickAndSendImageFromCamera,
                                                  child: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                GestureDetector(
                                                  onTap: () {
                                                    showAttachmentOptions(
                                                      context,
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.attach_file_rounded,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      suffixIcon: SizedBox(
                                        width: 80.w,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(
                                              end: 8.w,
                                              bottom: 12.h,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(
                                                  context,
                                                ).unfocus();
                                                setState(() {
                                                  showEmojiPicker =
                                                      !showEmojiPicker;
                                                });
                                              },
                                              child: Icon(
                                                Icons.emoji_emotions_outlined,
                                                color: AppColors.primary,
                                                size: 30.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ),

                  /// 🟧 Emoji Picker
                  if (showEmojiPicker)
                    SizedBox(
                      height: 300.h,
                      child: EmojiPicker(
                        textEditingController: _messageSendController,
                        onEmojiSelected: (category, emoji) {
                          _messageSendController.text += emoji.emoji;
                          _messageSendController
                              .selection = TextSelection.fromPosition(
                            TextPosition(
                              offset: _messageSendController.text.length,
                            ),
                          );
                        },
                        config: Config(
                          emojiViewConfig: const EmojiViewConfig(
                            emojiSizeMax: 28,
                          ),
                          categoryViewConfig: CategoryViewConfig(
                            backspaceColor: AppColors.primary,
                            iconColor: AppColors.primaryLight,
                            iconColorSelected: AppColors.primary,
                            indicatorColor: AppColors.primary,
                            dividerColor: Colors.grey[300],
                          ),
                          bottomActionBarConfig: const BottomActionBarConfig(
                            backgroundColor: AppColors.primary,
                          ),
                          searchViewConfig: const SearchViewConfig(),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum MessageType { text, image, video, audio, file }

class ChatMessage {
  final MessageType type;
  final String content;
  final bool isSender;
  final PlayerController? playerController;

  ChatMessage({
    required this.type,
    required this.content,
    required this.isSender,
    this.playerController,
  });
}

class FullScreenImageView extends StatelessWidget {
  final String imagePath;

  const FullScreenImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              child: PhotoView(
                imageProvider:
                    Image.file(File(imagePath), fit: BoxFit.contain).image,
              ),
            ),
          ),
          PositionedDirectional(
            start: 16.w,
            top: 50.h,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoViewerScreen extends StatefulWidget {
  final String path;
  const VideoViewerScreen({super.key, required this.path});

  @override
  State<VideoViewerScreen> createState() => _VideoViewerScreenState();
}

class _VideoViewerScreenState extends State<VideoViewerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.path));
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
    );

    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child:
            _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(controller: _chewieController!)
                : const CircularProgressIndicator(),
      ),
    );
  }
}
