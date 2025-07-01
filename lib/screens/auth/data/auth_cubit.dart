import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../core/cache/cache_helper.dart';
import '../../../core/constants/contsants.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  bool isSecureLogIn = true;
  isSecureLogInIcon(isSecuree) {
    isSecureLogIn = isSecuree;
    emit(IsSecureIcon());
  }

  bool isSecureRegister1 = true;
  isSecureRegisterIcon1(isSecuree) {
    isSecureRegister1 = isSecuree;
    emit(IsSecureIcon());
  }

  bool isSecureRegister2 = true;
  isSecureRegisterIcon2(isSecuree) {
    isSecureRegister2 = isSecuree;
    emit(IsSecureIcon());
  }

  bool isSecureNewPass1 = true;
  isSecureNewPassIcon1(isSecuree) {
    isSecureNewPass1 = isSecuree;
    emit(IsSecureIcon());
  }

  bool isSecureNewPass2 = true;
  isSecureNewPassIcon2(isSecuree) {
    isSecureNewPass2 = isSecuree;
    emit(IsSecureIcon());
  }

  bool agreeTerms = false;
  agreeTermsFun() {
    agreeTerms = !agreeTerms;
    emit(AgreeTermsSuccess());
  }

  Future register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String userType,
    required String category,
    required String countrycode,
    required String childbirthdate,
    required String childeducationlevel,
    required String childproblem,
    required String doctorSpecialty,
  }) async {
    emit(RegisterLoading());

    final response = await http.post(
      Uri.parse(
        "${baseUrl}api/auth/register",
      ).replace(queryParameters: {"type": CacheHelper.getUserType()}),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phoneNumber,
        "password": password,
        "user_type": userType,
        "category": category,
        "country_code": countrycode,
        "child_birthdate": childbirthdate,
        "child_education_level": childeducationlevel,
        "child_problem": childproblem,
        "doctor_specialty": doctorSpecialty,
      }),
    );

    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());

        final message = data["message"] ?? "تم التسجيل بنجاح";
        emit(RegisterSuccess(message: message));
      } catch (e) {
        debugPrint("Decoding error: $e");
        emit(RegisterFailure(error: "خطأ في تحليل بيانات الاستجابة"));
      }
    } else {
      try {
        final errorData = jsonDecode(response.body);

        if (errorData['validationResult'] != null) {
          final List validationErrors = errorData['validationResult'];
          final List<String> errorMessages = [];

          for (var error in validationErrors) {
            final path = error['path']?.join('.') ?? '';
            final message = error['message'] ?? 'خطأ غير معروف في $path';
            errorMessages.add('$path: $message');
          }

          final fullErrorMessage = errorMessages.join('\n');
          emit(RegisterFailure(error: fullErrorMessage));
        } else {
          emit(
            RegisterFailure(error: errorData['message'] ?? 'حدث خطأ غير متوقع'),
          );
        }
      } catch (e) {
        emit(RegisterFailure(error: 'فشل تحليل رسالة الخطأ'));
      }
    }
  }


  Future logIn({required String email, required String password}) async {
    emit(LogInLoading());

    try {
      final response = await http.post(
        Uri.parse("${baseUrl}api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = data["message"] ?? "تم تسجيل الدخول بنجاح";
        final token = data["token"];
        await CacheHelper.setUserToken(token);
        debugPrint("Saved Token: $token");
        emit(LogInSuccess(message: message));
      } else {
        final errorMessage = data["message"] ?? "فشل تسجيل الدخول";
        emit(LogInFailure(error: errorMessage));
      }
    } catch (e) {
      debugPrint("Decoding error: $e");
      emit(LogInFailure(error: "حدث خطأ غير متوقع أثناء تسجيل الدخول"));
    }
  }

  Future logOut() async {
    emit(LogOutLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/logout"),
      body: {
        "lang": CacheHelper.getLang(),
        "user_id": CacheHelper.getUserId(),
        "device_id": CacheHelper.getDeviceToken(),
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (data["key"] == 1) {
      CacheHelper.setUserId("");
      // CacheHelper.setUserToken("");
      emit(LogOutSuccess(message: data["msg"]));
    } else {
      emit(LogOutFailure(error: data["msg"]));
    }
  }

  String? resetToken;

  Future forgetPass({required String email}) async {
    emit(ForgetPassLoading());
    final response = await http.post(
      Uri.parse("${baseUrl}api/auth/forgot-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      resetToken = data["reset_token"];
      debugPrint("Reset Token: $resetToken");
      emit(ForgetPassSuccess(message: data["message"]));
    } else {
      emit(ForgetPassFailure(error: "خطأ في الطلب"));
    }
  }

  Future resetPass({required String password}) async {
    emit(ResetPassLoading());

    if (resetToken == null) {
      emit(ResetPassFailure(error: "الرمز مفقود"));
      return;
    }

    final response = await http.post(
      Uri.parse("${baseUrl}api/auth/reset-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"token": resetToken, "password": password}),
    );

    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      emit(ResetPassSuccess(message: data["message"]));
    } else {
      final data = jsonDecode(response.body);
      emit(ResetPassFailure(error: data["error"] ?? "خطأ غير معروف"));
    }
  }

}
