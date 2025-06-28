import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';
import '../../screens/auth/views/login/login.dart';
import 'app_button.dart';
import 'app_router.dart';
import 'app_text.dart';
import 'custom_lottie_widget.dart';

class LoginFirst extends StatelessWidget {
  const LoginFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50.h),
        CustomLottieWidget(lottieName: Assets.img.emptyorder),
        AppText(
          text: "برجاء تسجيل الدخول اولا",
          size: 20.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 50.h),
        AppButton(
          onPressed: () {
            AppRouter.navigateTo(context, const LogIn());
          },
          child: AppText(
            text: "تسجيل الدخول",
            size: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
