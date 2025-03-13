import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../generated/locale_keys.g.dart';
import '../../cache/cache_helper.dart';
import '../../constants/contsants.dart';
import '../model/on_boarding_model.dart';
import '../model/chat_messages_model.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  // int bottomNavIndex = 1;
  // List<Widget> bottomNavScreens = [
  //   const Store(),
  //   const Home(),
  //   const Orders(),
  //   const Chats(),
  // ];

  // void changebottomNavIndex(index) async {
  //   bottomNavIndex = index;
  //   emit(ChangeBottomNav());
  // }

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

  int changeFavIndex = 0;
  void changeFavIndexs({required int index}) {
    changeFavIndex = index;
    emit(ChangeIndex());
  }

  int changeTermsIndex = -1;
  void changeTermsIndexs({required int index}) {
    changeTermsIndex = index;

    emit(ChangeIndex());
  }

  List<OnBoardingModel> onBoardingList = [];
  Future intro() async {
    emit(GetIntroLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/intro"),
      body: {"lang": CacheHelper.getLang()},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data["data"].toString());
    onBoardingList = List<OnBoardingModel>.from(
      (data["data"] ?? []).map((e) => OnBoardingModel.fromJson(e)),
    );

    if (data["key"] == 1) {
      emit(GetIntroSuccess());
    } else {
      emit(GetIntroFailure(error: data["msg"]));
    }
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

  List<File> orderImages = [];
  Future<void> getOrderImage(BuildContext context) async {
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
      orderImages = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeOrderImage() {
    orderImages.clear();
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

  List<ChatMessagesModel> chatMessages = [];
  Map chatDetails = {};
  Future getChatMessages({
    required String salerId,
    String roomId = "",
    bool isloading = true,
  }) async {
    if (isloading) {
      emit(GetChatMessagesLoading());
    }
    try {
      http.Response response = await http
          .post(
            Uri.parse("${baseUrl}api/all-chats"),
            body: {
              "lang": CacheHelper.getLang(),
              "user_id": CacheHelper.getUserId(),
              "saler_id": salerId,
              "room_id": roomId,
            },
          )
          .timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data["key"] == 1) {
          chatDetails = data;
          debugPrint(chatDetails.toString());
          chatMessages = List<ChatMessagesModel>.from(
            (data["data"] ?? [])
                .map((e) => ChatMessagesModel.fromJson(e))
                .toList()
                .reversed,
          );

          emit(GetChatMessagesSuccess());
        } else {
          debugPrint(data["msg"]);
          emit(GetChatMessagesFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(GetChatMessagesFailure(error: error.toString()));
      }
    }
  }

  Future sendMessage({required String message}) async {
    emit(SendMessageLoading());
    try {
      http.Response response = await http
          .post(
            Uri.parse("${baseUrl}api/store-chat"),
            body: {
              "lang": CacheHelper.getLang(),
              "from_id": CacheHelper.getUserId(),
              "to_id":
                  CacheHelper.getUserType() == "saler"
                      ? chatDetails["user_id"].toString()
                      : chatDetails["saler_id"].toString(),
              "type": "text",
              "message": message,
            },
          )
          .timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data["key"] == 1) {
          debugPrint(data["data"].toString());
          emit(SendMessageSuccess());
          getChatMessages(
            salerId: chatDetails["saler_id"].toString(),
            roomId: chatDetails["room_id"].toString(),
            isloading: false,
          );
        } else {
          debugPrint(data["msg"]);
          emit(SendMessageFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(SendMessageFailure(error: error.toString()));
      }
    }
  }
}
