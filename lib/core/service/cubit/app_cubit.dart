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

  // int bottomProviderNavIndex = 1;
  // List<Widget> bottomProviderNavScreens = [
  //   const ProviderOrders(),
  //   const ProviderHome(),
  //   const ProviderNotifications(),
  //   const ProviderChats(),
  // ];

  // void changebottomProviderNavIndex(index) async {
  //   bottomProviderNavIndex = index;
  //   emit(ChangeBottomNav());
  // }

  int typeIndex = 0;
  void changeTypeIndex({required int index}) {
    typeIndex = index;
    emit(ChangeIndex());
  }

  double? lat = 0;
  double? lng = 0;
  String? address;
  void changeAddress({required String newAddress}) {
    address = newAddress;
    emit(ChangeIndex());
  }

  int paymentIndex = -1;
  void changePaymentIndex({required int index}) {
    paymentIndex = index;
    emit(ChangeIndex());
  }

  int paymentlocatIndex = -1;
  void changePaymentlocatIndex({required int index}) {
    paymentlocatIndex = index;
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

  int shipIndex = -1;
  void changeShipIndex({required int index}) {
    shipIndex = index;
    emit(ChangeIndex());
  }

  int count = 1;
  void increseCount() {
    count++;
    emit(ChangeCount());
  }

  void decreseCount() {
    if (count > 0) {
      count--;
    }
    emit(ChangeCount());
  }

  bool hasCertificate = false;
  void changeCertificate() {
    hasCertificate = !hasCertificate;
    emit(ChangeIndex());
  }

  bool isSecureLogIn = true;
  isSecureLogInIcon(isSecuree) {
    isSecureLogIn = isSecuree;
    emit(IsSecureIcon());
  }

  int isTab = -1;
  changeIsTab({required int index}) {
    isTab = index;
    emit(IsSecureIcon());
  }

  int changeLangIndex = 0;
  void changeLangIndexs({required int index}) {
    changeLangIndex = index;
    emit(ChangeIndex());
  }

  int changeIndex = 0;
  void changeIndexs({required int index}) {
    changeIndex = index;
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

  int changeTermsIndex = -1;
  void changeTermsIndexs({required int index}) {
    changeTermsIndex = index;

    emit(ChangeIndex());
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

  Set<int> loveVideoIndexes = {};

  void changeVideoLoveIndex(int index) {
    if (loveVideoIndexes.contains(index)) {
      loveVideoIndexes.remove(index);
    } else {
      loveVideoIndexes.add(index);
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
  List<File> serviceImage = [];
  Future<void> getserviceImage(BuildContext context) async {
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
      serviceImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeserviceImage() {
    serviceImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> productImage = [];
  Future<void> getproductImage(BuildContext context) async {
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
      productImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeproductImage() {
    productImage.clear();
    emit(RemoveImageSuccess());
  }

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

  List<File> postVideos = [];

  Future<void> getPostVideos(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("اختر مصدر الفيديو"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text("الكاميرا"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text("المعرض"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    List<XFile>? pickedVideos = [];

    if (pickedOption == 1) {
      XFile? pickedVideo = await picker.pickVideo(source: ImageSource.camera);
      if (pickedVideo != null) {
        pickedVideos = [pickedVideo];
      }
    } else if (pickedOption == 2) {
      XFile? pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedVideo != null) {
        pickedVideos = [pickedVideo];
      }
    }

    if (pickedVideos.isNotEmpty) {
      postVideos.addAll(pickedVideos.map((video) => File(video.path)));
      emit(ChooseVideoSuccess());
    }
  }

  void removePostVideo(int index) {
    postVideos.removeAt(index);
    emit(RemoveVideoSuccess());
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

  String aboutUsTitle = '';
  Future aboutUs() async {
    emit(AboutUsLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/page"),
      body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "title": "about",
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    aboutUsTitle = data["data"]['desc'];
    debugPrint(data.toString());

    if (data["key"] == 1) {
      emit(AboutUsSuccess());
    } else {
      emit(AboutUsFailure(error: data["msg"]));
    }
  }

  String privacyPolicyTitle = '';
  Future privacyPolicy() async {
    emit(PrivacyPolicyLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/page"),
      body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "title": "condition",
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    privacyPolicyTitle = data["data"]['desc'];
    debugPrint(data.toString());

    if (data["key"] == 1) {
      emit(PrivacyPolicySuccess());
    } else {
      emit(PrivacyPolicyFailure(error: data["msg"]));
    }
  }

  Future contactUs({
    required String name,
    required String phone,
    required String message,
  }) async {
    emit(ContactUsLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/contact-us"),
      body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "name": name,
        "phone": phone,
        "message": message,
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (data["key"] == 1) {
      emit(ContactUsSuccess(message: data["msg"]));
    } else {
      emit(ContactUsFailure(error: data["msg"]));
    }
  }

  // List<ChatMessagesModel> chatMessages = [];
  // Map chatDetails = {};
  // Future getChatMessages({
  //   required String salerId,
  //   String roomId = "",
  //   bool isloading = true,
  // }) async {
  //   if (isloading) {
  //     emit(GetChatMessagesLoading());
  //   }
  //   try {
  //     http.Response response = await http
  //         .post(
  //           Uri.parse("${baseUrl}api/all-chats"),
  //           body: {
  //             "lang": CacheHelper.getLang(),
  //             "user_id": CacheHelper.getUserId(),
  //             "saler_id": salerId,
  //             "room_id": roomId,
  //           },
  //         )
  //         .timeout(const Duration(milliseconds: 8000));

  //     if (response.statusCode == 500) {
  //       emit(ServerError());
  //     } else {
  //       Map<String, dynamic> data = jsonDecode(response.body);

  //       if (data["key"] == 1) {
  //         chatDetails = data;
  //         debugPrint(chatDetails.toString());
  //         chatMessages = List<ChatMessagesModel>.from(
  //           (data["data"] ?? [])
  //               .map((e) => ChatMessagesModel.fromJson(e))
  //               .toList()
  //               .reversed,
  //         );

  //         emit(GetChatMessagesSuccess());
  //       } else {
  //         debugPrint(data["msg"]);
  //         emit(GetChatMessagesFailure(error: data["msg"]));
  //       }
  //     }
  //   } catch (error) {
  //     if (error is TimeoutException) {
  //       debugPrint("Request timed out");
  //       emit(Timeoutt());
  //     } else {
  //       emit(GetChatMessagesFailure(error: error.toString()));
  //     }
  //   }
  // }

  // Future sendMessage({required String message}) async {
  //   emit(SendMessageLoading());
  //   try {
  //     http.Response response = await http
  //         .post(
  //           Uri.parse("${baseUrl}api/store-chat"),
  //           body: {
  //             "lang": CacheHelper.getLang(),
  //             "from_id": CacheHelper.getUserId(),
  //             "to_id":
  //                 CacheHelper.getUserType() == "saler"
  //                     ? chatDetails["user_id"].toString()
  //                     : chatDetails["saler_id"].toString(),
  //             "type": "text",
  //             "message": message,
  //           },
  //         )
  //         .timeout(const Duration(milliseconds: 8000));

  //     if (response.statusCode == 500) {
  //       emit(ServerError());
  //     } else {
  //       Map<String, dynamic> data = jsonDecode(response.body);

  //       if (data["key"] == 1) {
  //         debugPrint(data["data"].toString());
  //         emit(SendMessageSuccess());
  //         getChatMessages(
  //           salerId: chatDetails["saler_id"].toString(),
  //           roomId: chatDetails["room_id"].toString(),
  //           isloading: false,
  //         );
  //       } else {
  //         debugPrint(data["msg"]);
  //         emit(SendMessageFailure(error: data["msg"]));
  //       }
  //     }
  //   } catch (error) {
  //     if (error is TimeoutException) {
  //       debugPrint("Request timed out");
  //       emit(Timeoutt());
  //     } else {
  //       emit(SendMessageFailure(error: error.toString()));
  //     }
  //   }
  // }

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
      title: 'عباقرة التفكير',
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
  ];

  List<HearingModel> hearings = [
    HearingModel(videoUrl: '', questions: [''], answers: ''),
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

  List postsList = [];
  Future postsView() async {
    emit(PostsViewLoading());
    http.Response response = await http.get(Uri.parse("${baseUrl}api/posts"));
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    List<dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());
    postsList = data;
    if (response.statusCode == 200) {
      emit(PostsViewSuccess());
    } else {
      emit(PostsViewFailure());
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
