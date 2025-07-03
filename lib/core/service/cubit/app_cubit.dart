// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/models/focus_model.dart';
import 'package:hemtnaa/core/service/models/games_models.dart';
import 'package:hemtnaa/core/service/models/hearing_model.dart';
import 'package:hemtnaa/core/service/models/questions_model.dart';
import 'package:hemtnaa/core/service/models/stories_model.dart';
import 'package:hemtnaa/screens/child_screens/home_layout/doctors/doctors.dart';
import 'package:hemtnaa/screens/doctor_screens/home_layout/doc_chat/doc_chat.dart';
import 'package:hemtnaa/screens/doctor_screens/home_layout/doc_rates/doc_rates.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../screens/child_screens/home_layout/activities/activities.dart';
import '../../../screens/child_screens/home_layout/chats/chats.dart';
import '../../../screens/child_screens/home_layout/games/games.dart';
import '../../../screens/child_screens/home_layout/home/home.dart';
import '../../../screens/doctor_screens/home_layout/doc_home/doc_home.dart';
import '../../cache/cache_helper.dart';
import '../../constants/contsants.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int bottomNavIndex = 2;
  List<Widget> bottomNavScreens = [
    const Games(),
    const Chats(),
    const Home(),
    const Activities(),
    const Doctors(),
  ];

  void changebottomNavIndex(index) async {
    bottomNavIndex = index;
    emit(ChangeBottomNav());
  }

  int bottomDocNavIndex = 0;
  List<Widget> bottomDocNavScreens = [
    const DocHome(),
    const DocChat(),
    const DocRates(),
  ];

  void changebottomDocNavIndex(index) async {
    bottomDocNavIndex = index;
    emit(ChangeBottomNav());
  }

  int typeIndex = 0;
  void changeTypeIndex({required int index}) {
    typeIndex = index;
    emit(ChangeIndex());
  }

  int drawerIndex = -1;
  void changedrawerIndex({required int index}) {
    if (drawerIndex != index) {
      drawerIndex = index;
      emit(ChangeIndex());
    }
    emit(ChangeIndex());
  }

  List<int> selectedIndexes = [];

  void changeActiveIndexs({required int index}) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
    emit(ChangeIndex());
  }

  double score = 70.0;
  final double maxScore = 100.0;

  void increaseScore(double value) {
    if (score + value <= maxScore) {
      score += value;
    } else {
      score = maxScore;
    }
    emit(ScoreUpdated());
  }

  Set<int> loveIndexes = {};

  void changeLoveIndex(int index) {
    if (loveIndexes.contains(index)) {
      loveIndexes.remove(index);
    } else {
      loveIndexes.add(index);
    }
    emit(ChangeIndex());
  }

  List<File> activityImage = [];

  Future<void> getActivityImage(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      activityImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeActivityImage() {
    activityImage.clear();
    emit(RemoveImageSuccess());
  }

  // Get Images
  List<File> postImages = [];
  Future<void> getPostImages(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("اختر مصدر الصورة"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("الكاميرا"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("المعرض"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    List<XFile>? pickedImages = [];

    if (pickedOption == 1) {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        pickedImages = [pickedImage];
      }
    } else if (pickedOption == 2) {
      pickedImages = await picker.pickMultiImage();
    }

    if (pickedImages.isNotEmpty) {
      postImages.addAll(pickedImages.map((image) => File(image.path)));
      emit(ChooseImageSuccess());
    }
  }

  void removePostImage(int index) {
    postImages.removeAt(index);
    emit(RemoveImageSuccess());
  }

  List<File> messageImage = [];
  Future<void> getMessageImage(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      messageImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeMessageImage() {
    messageImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> profileImage = [];
  Future<void> getProfileImage(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      profileImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeProfileImage() {
    profileImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> providerprofileImage = [];
  Future<void> getproviderprofileImage(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      providerprofileImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeproviderprofileImage() {
    providerprofileImage.clear();
    emit(RemoveImageSuccess());
  }

  String? profileImageUrl;
  Future uploadProfileImage() async {
    emit(UploadImagesLoading());
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}api/upload-image"),
    );
    request.fields['lang'] = CacheHelper.getLang();

    for (var image in profileImage) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: image.path.split('/').last,
      );
      request.files.add(multipartFile);
    }
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    Map<String, dynamic> data = jsonDecode(responseBody);
    profileImageUrl = data["app_url"];
    debugPrint("imageUrl is $profileImageUrl");

    if (data["key"] == 1) {
      emit(UploadImagesSuccess());
    } else {
      emit(UploadImagesFailure());
    }
  }

  List<GamesModels> games = [
    GamesModels(
      title: 'بازل العباقرة',
      image: Assets.img.puzzle.path,
      description:
          'اختبر مهاراتك في التركيب والتفكير المنطقي مع لعبة بازل ثلاثية الأبعاد! اجمع القطع المتناثرة لتشكّل صورًا مذهلة وتحدّى نفسك في مستويات متعددة الصعوبة.',
      button: 'Puzzle',
    ),
    GamesModels(
      title: 'تحدي الألغاز',
      image: Assets.img.mystery.path,
      description:
          'أطلق العنان لذكائك مع مئات الألغاز الممتعة والمتنوعة! هل يمكنك حلها جميعًا؟ ألغاز منطقية، رياضية، وأسئلة خفيفة ستُشعل عقلك.',
      button: 'لعبة الالغاز',
    ),
    GamesModels(
      title: 'الاشكال المتطابقه',
      image: Assets.img.brain.path,
      description:
          'مرّن دماغك مع ألعاب ذكاء صُمّمت لاختبار مهاراتك في المنطق، التحليل، وسرعة البديهة. مراحل تزداد صعوبة وتحديات جديدة كل يوم!',
      button: 'لعبة التركيز',
    ),
    GamesModels(
      title: 'ذاكرة حديدية',
      image: Assets.img.shapes.path,
      description:
          'اختبر قوة ذاكرتك! اقلب البطاقات، طابق الصور، وحقق أعلى النتائج. لعبة ممتعة مناسبة لجميع الأعمار لتنشيط العقل وتحسين التركيز.',
      button: 'لعبة الذاكرة',
    ),
    GamesModels(
      title: 'قصص ممتعه',
      image: Assets.img.strories.path,
      description:
          'اكتشف عالمًا من القصص الشيقة والمسلية التي تناسب جميع أعمار الأطفال. استمع إلى قصص تعليمية وترفيهية تساعد على تنمية الخيال واللغة، وتزرع القيم الجميلة في قلوب الصغار.',
      button: 'سماع القصص',
    ),

    GamesModels(
      title: 'استمتع وتعلّم بالأصوات',
      image: Assets.img.audio.path,
      description:
          'مرحبًا بك في عالم السمعيات المدهش! في هذا القسم، يستمتع الأطفال بسماع القصص، والأناشيد، والأصوات التعليمية الممتعة التي تنمّي مهاراتهم اللغوية والسمعية. محتوى ممتع، آمن، ومناسب لجميع الأعمار يساعد الأطفال على التعلّم بطريقة مرحة وسهلة',
      button: 'عالم السمعيات',
    ),
  ];

  List<QuestionsModel> questions = [
    QuestionsModel(
      quistion: 'ما الشئ الذي الذي له أوراق ولكنه ليس نباتاً ؟',
      answers: ['شجرة', 'عشب', 'زهرة', 'كتاب'],
      correctAnswer: 'كتاب',
    ),
    QuestionsModel(
      quistion: "ما اسم هذا الحيوان ؟",
      image: Assets.img.lion.path,
      answers: ['اسد', 'حمار', 'كلب', 'فيل'],
      correctAnswer: 'اسد',
    ),
    QuestionsModel(
      quistion: "ما الشئ الذي كلما أخذت منه كبر ؟",
      answers: ['البالون', 'الحفرة', 'الكعكة', 'الكتاب'],
      correctAnswer: 'الحفرة',
    ),
    QuestionsModel(
      quistion: "ما لون هذه الفاكهة؟",
      image: Assets.img.apple.path,
      answers: ['احمر', 'اخضر', 'ازرق', 'اسود'],
      correctAnswer: 'احمر',
    ),
    QuestionsModel(
      quistion: "ما هو الشئ الذي لا يمكن أن تراه ولكنه يراك؟",
      answers: ['الضوء', 'الصوت', 'الظل', 'الهواء'],
      correctAnswer: 'الظل',
    ),
    QuestionsModel(
      quistion: "ما اسم الشكل في الصورة ؟",
      image: Assets.img.tree.path,
      answers: ['شجرة', 'حيوان', 'نخلة', 'وردة'],
      correctAnswer: 'شجرة',
    ),
  ];

  List<StoriesModel> stories = [
    StoriesModel(
      name: "اصحاب الفيل",
      video: "https://www.youtube.com/watch?v=YcwgwTUkxsM",
      thumbnail: 'https://img.youtube.com/vi/YcwgwTUkxsM/hqdefault.jpg',
    ),
    StoriesModel(
      name: "بر الوالدين",
      video: "https://www.youtube.com/watch?v=4CLcuR3Tp0c",
      thumbnail: 'https://img.youtube.com/vi/4CLcuR3Tp0c/hqdefault.jpg',
    ),
    StoriesModel(
      name: "النبي والطفل",
      video: "https://www.youtube.com/watch?v=67VgFvJ18Hk&t=126s",
      thumbnail: 'https://img.youtube.com/vi/67VgFvJ18Hk/hqdefault.jpg',
    ),
    StoriesModel(
      name: "ابراهيم عليه السلام",
      video: "https://www.youtube.com/watch?v=RirEWHlQ8dI",
      thumbnail: 'https://img.youtube.com/vi/RirEWHlQ8dI/hqdefault.jpg',
    ),
    StoriesModel(
      name: "يوسف عليه السلام",
      video: "https://www.youtube.com/watch?v=RkiD_W5ffhU",
      thumbnail: 'https://img.youtube.com/vi/RkiD_W5ffhU/hqdefault.jpg',
    ),
    StoriesModel(
      name: "يونس عليه السلام",
      video: "https://www.youtube.com/watch?v=sRqm3DNsFps",
      thumbnail: 'https://img.youtube.com/vi/sRqm3DNsFps/hqdefault.jpg',
    ),
    StoriesModel(
      name: "نوح عليه السلام",
      video: "https://www.youtube.com/watch?v=wbMT-i-GU-A",
      thumbnail: 'https://img.youtube.com/vi/wbMT-i-GU-A/hqdefault.jpg',
    ),
    StoriesModel(
      name: "عيد الفطر",
      video: "https://www.youtube.com/watch?v=jqVbzms4A2k",
      thumbnail: 'https://img.youtube.com/vi/jqVbzms4A2k/hqdefault.jpg',
    ),
    StoriesModel(
      name: "الفيل فلفول",
      video: "https://youtu.be/B3jiTfinrq8?si=K8WwVfl8JqHGcZZe",
      thumbnail: 'https://img.youtube.com/vi/B3jiTfinrq8/hqdefault.jpg',
    ),
    StoriesModel(
      name: "فئران",
      video: "https://youtu.be/XROhZrS1Ol4?si=MZ0YvBUu01bqis6j",
      thumbnail: 'https://img.youtube.com/vi/XROhZrS1Ol4/maxresdefault.jpg',
    ),
    StoriesModel(
      name: "أرنوب المهمل",
      video: "https://youtu.be/jrPGXAdvmvE?si=wm2t-5hdt_y_qhD6",
      thumbnail: 'https://img.youtube.com/vi/jrPGXAdvmvE/maxresdefault.jpg',
    ),
    StoriesModel(
      name: "الاسد والصياد",
      video: "https://www.youtube.com/watch?v=39bnjGHM7dM",
      thumbnail: 'https://img.youtube.com/vi/39bnjGHM7dM/maxresdefault.jpg',
    ),
  ];

  List<HearingModel> hearing = [
    HearingModel(
      quistionText: 'من هو الحيوان صاحب هذا الصوت ؟',
      quistion: 'https://www.youtube.com/watch?v=EdTcFAeW7wg',
      answers: ['القرد', 'القطه', 'الاسد', 'الفيل'],
      correctAnswer: 'الاسد',
    ),
    HearingModel(
      quistionText: 'ما هذا الصوت ؟',
      quistion: "https://www.youtube.com/watch?v=C-hzP3mOBGY",
      answers: ['صاروخ', 'سياره', 'حيوان', 'مطر'],
      correctAnswer: 'مطر',
    ),
    HearingModel(
      quistionText: 'من هو الحيوان صاحب هذا الصوت ؟',
      quistion: "https://www.youtube.com/watch?v=VKdXZz6N8bk",
      answers: ['الكلب', 'القطه', 'الاسد', 'الفيل'],
      correctAnswer: 'الكلب',
    ),
    HearingModel(
      quistionText: 'ما هذا الصوت ؟',
      quistion: "https://www.youtube.com/watch?v=lzrfno225Oo",
      answers: ['صاروخ', 'سياره', 'حيوان', 'مطر'],
      correctAnswer: 'سياره',
    ),
    HearingModel(
      quistionText: 'ما هذا الصوت ؟',
      quistion: "https://www.youtube.com/watch?v=QDGyPGLGQNw",
      answers: ['كتاب', 'زهرة', 'عشب', 'شجره'],
      correctAnswer: 'شجره',
    ),
    HearingModel(
      quistionText: 'ما هذا الصوت ؟',
      quistion: "https://www.youtube.com/watch?v=04dHPisbKt4",
      answers: ['كتاب', 'زهرة', 'موسيقى', 'شجره'],
      correctAnswer: 'موسيقى',
    ),
  ];

  int _currentPage = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;

  void answerQuestion(int selectedIndex) {
    if (_answered) return;

    _selectedIndex = selectedIndex;
    _answered = true;

    final correctAnswer = questions[_currentPage].correctAnswer;
    final selectedAnswer = questions[_currentPage].answers[selectedIndex];

    if (selectedAnswer == correctAnswer) {
      _score += 10;
    }

    emit(QuizAnsweredState(_currentPage, _score, _answered, _selectedIndex));
  }

  void nextQuestion() {
    if (_currentPage < questions.length - 1) {
      _currentPage++;
      _answered = false;
      _selectedIndex = null;
      emit(
        QuizNextQuestionState(_currentPage, _score, _answered, _selectedIndex),
      );
    }
  }

  void resetQuiz() {
    _currentPage = 0;
    _score = 0;
    _answered = false;
    _selectedIndex = null;
    emit(QuizInitialState());
  }

  final List<FocusModel> focusList = [
    FocusModel(
      question: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12.r),
        child: Container(
          height: 200.w,
          width: 200.w,
          margin: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      answers: [
        FocusAnswer(
          id: 1,
          widget: Container(
            height: 100.w,
            width: 100.w,
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        FocusAnswer(
          id: 2,
          widget: Container(
            height: 100.w,
            width: 100.w,
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        FocusAnswer(
          id: 3,
          widget: Container(
            height: 100.w,
            width: 100.w,
            margin: EdgeInsets.all(16.w),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
        ),
        FocusAnswer(
          id: 4,
          widget: CustomPaint(
            size: Size(100.w, 100.w),
            painter: TrianglePainter(),
          ),
        ),
      ],
      correctAnswerId: 1,
    ),
    FocusModel(
      question: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12.r),
        child: Container(
          height: 200.w,
          width: 200.w,
          margin: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            color: Colors.cyanAccent,
            shape: BoxShape.circle,
          ),
        ),
      ),
      answers: [
        FocusAnswer(
          id: 1,
          widget: Container(
            height: 100.w,
            width: 100.w,
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        FocusAnswer(
          id: 2,
          widget: Container(
            height: 100.w,
            width: 100.w,
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        FocusAnswer(
          id: 3,
          widget: Container(
            height: 100.w,
            width: 100.w,
            margin: EdgeInsets.all(16.w),
            decoration: const BoxDecoration(
              color: Colors.cyanAccent,
              shape: BoxShape.circle,
            ),
          ),
        ),
        FocusAnswer(
          id: 4,
          widget: CustomPaint(
            size: Size(100.w, 100.w),
            painter: TrianglePainter(),
          ),
        ),
      ],
      correctAnswerId: 3,
    ),
  ];

  int activityScore = 0;

  void incrementScoreByActivities() {
    activityScore += selectedIndexes.length * 20;
    emit(ActivityScoreChanged());
  }

  void resetScore() {
    activityScore = 0;
    emit(ActivityScoreChanged());
  }

  List postsList = [];
  Future getPosts() async {
    emit(GetPostsLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}api/posts"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());
    debugPrint("Posts API response: $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      postsList = data["data"];
      emit(GetPostsSuccess());
    } else {
      emit(GetPostsFailure(error: data["message"] ?? "حدث خطاء"));
    }
  }

  Future createPosts({
    required String title,
    required String content,
    required String category,
    required String doctorId,
  }) async {
    emit(CreatePostLoading());
    String? token = CacheHelper.getUserToken();

    try {
      var uri = Uri.parse("${baseUrl}api/posts/");
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll({"Authorization": "Bearer $token"});

      // البيانات النصية
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['category'] = category;
      request.fields['doctor_id'] = doctorId;

      // إضافة الصور
      for (var imageFile in postImages) {
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile(
          'image', // اسم المفتاح في الـ backend إذا كان يقبل array
          stream,
          length,
          filename: imageFile.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      // تنفيذ الطلب
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.headers['content-type']?.contains('application/json') ==
          true) {
        var data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(CreatePostSuccess(message: data["message"] ?? "تم النشر بنجاح"));
          postImages.clear();
          getPosts();
        } else {
          emit(CreatePostFailure(error: data["message"] ?? "حدث خطأ"));
        }
      } else {
        debugPrint("Unexpected response: ${response.body}");
        emit(CreatePostFailure(error: "Unexpected response from server"));
      }
    } catch (e) {
      emit(CreatePostFailure(error: "حدث خطأ: ${e.toString()}"));
    }
  }

  Future doLikePost({required String postId}) async {
    emit(DoLikePostLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/posts/$postId/like"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"user_id": '1'}),
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());
    debugPrint("Posts API response: $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(DoLikePostSuccess());
      getPosts();
    } else {
      emit(DoLikePostFailure(error: data["message"] ?? "حدث خطاء"));
    }
  }

  Future addComment({
    required String postId,
    required String comment,
    required String userId,
  }) async {
    emit(AddCommentLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/posts/$postId/comment"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"user_id": userId, "comment": comment}),
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());
    debugPrint("Posts API response: $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(AddCommentSuccess(message: data["message"] ?? "تم النشر بنجاح"));
      getComments(postId: postId);
    } else {
      emit(AddCommentFailure(error: data["message"] ?? "حدث خطاء"));
    }
  }

  List comments = [];
  Future getComments({required String postId}) async {
    emit(GetCommentsLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}api/posts/$postId/comments"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());
    debugPrint("Posts API response: $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      comments = data["data"];
      emit(GetCommentsSuccess());
    } else {
      emit(GetCommentsFailure(error: data["message"] ?? "حدث خطاء"));
    }
  }

  Map userMap = {};
  Future showUser() async {
    emit(ShowUserLoading());
    http.Response response = await http.get(
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CacheHelper.getUserToken()}",
      },
      Uri.parse("${baseUrl}api/auth/me"),
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    debugPrint(data.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      userMap = data;
      emit(ShowUserSuccess());
    } else {
      emit(ShowUserFailure(error: data["msg"]));
    }
  }

  Future updateUser({
    required String firstName,
    required String lastName,
    required String email,
    required String profileId,
  }) async {
    emit(UpdateUserLoading());

    try {
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse("${baseUrl}api/users/$profileId"),
      );
      request.headers['Authorization'] = 'Bearer ${CacheHelper.getUserToken()}';
      request.fields['first_name'] = firstName;
      request.fields['last_name'] = lastName;
      request.fields['email'] = email;

      if (profileImage.isNotEmpty) {
        final file = profileImage.first;
        final stream = http.ByteStream(file.openRead());
        final length = await file.length();

        final multipartFile = http.MultipartFile(
          'profile_picture',
          stream,
          length,
          filename: file.path.split('/').last,
        );

        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);

      debugPrint(data.toString());

      if (response.statusCode == 500) {
        emit(ServerError());
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateUserSuccess(message: data["message"]));
        profileImage.clear();
        profileImageUrl = null;
        showUser();
      } else {
        emit(UpdateUserFailure(error: data["message"]));
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(UpdateProfileFailure(error: error.toString()));
      }
    }
  }

  Future addActivity({
    required String activityName,
    required String childName,
    required String details,
    required String startDate,
    required String endDate,
  }) async {
    emit(AddActivityLoading());

    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}api/activities/"),
    );

    request.headers['Authorization'] = 'Bearer ${CacheHelper.getUserToken()}';
    request.headers['Accept'] = 'application/json';
    request.fields['activity_name'] = activityName;
    request.fields['child_name'] = childName;
    request.fields['details'] = details;
    request.fields['start_date'] = startDate;
    request.fields['end_date'] = endDate;

    if (activityImage.isNotEmpty) {
      final file = activityImage.first;
      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final multipartFile = http.MultipartFile(
        'activity_image',
        stream,
        length,
        filename: file.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    debugPrint('Status: ${response.statusCode}');
    debugPrint('Body: $responseBody');

    if (responseBody.trim().startsWith('<')) {
      emit(AddActivityFailure(error: 'Unexpected HTML response'));
      return;
    }

    final data = jsonDecode(responseBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(
        AddActivitySuccess(
          message: data["message"] ?? "Activity added successfully",
        ),
      );
      getActivities();
      activityImage.clear();
    } else {
      emit(AddActivityFailure(error: data["message"] ?? "Unknown error"));
    }
  }

  List getActivitiesList = [];
  Future getActivities() async {
    emit(GetActivitiesLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}api/activities"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      getActivitiesList = data["data"];
      emit(GetActivitiesSuccess());
    } else {
      emit(GetActivitiesFailure(error: "Failed to fetch activities"));
    }
  }

  List doctorsList = [];

  Future getDoctors() async {
    emit(GetUsersLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");

    http.Response response = await http.get(
      Uri.parse("${baseUrl}api/users/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List allUsers = data["data"];

      doctorsList =
          allUsers.where((user) => user["user_type"] == "doctor").toList();

      debugPrint("Doctors List: $doctorsList");

      emit(GetUsersSuccess());
    } else {
      emit(GetUsersFailure(error: "Failed to fetch users"));
    }
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
