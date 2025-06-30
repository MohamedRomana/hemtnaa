import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/cache/cache_helper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomAuthHeader extends StatelessWidget {
  final bool? isRegister;
  final bool? isOtp;
  final bool? isresetPass;

  const CustomAuthHeader({
    super.key,
    this.isRegister = false,
    this.isOtp = false,
    this.isresetPass = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 434.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 434.h,
            width: double.infinity,
            color: AppColors.primary,
          ),
          PositionedDirectional(
            start: CacheHelper.getLang() == "ar" ? 0.w : null,
            end: CacheHelper.getLang() == "en" ? 0.w : null,
            top: 170.h,
            child: Image.asset(
              Assets.img.onboarding.path,
              fit: BoxFit.cover,
            ),
          ),
          PositionedDirectional(
            start: 24.w,
            top: isRegister! || isOtp! || isresetPass! ? 140.h : 90.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isRegister!) ...{
                  AppText(
                    text: LocaleKeys.new_registration.tr(),
                    size: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                } else if (isOtp!) ...{
                  AppText(
                    text: LocaleKeys.verificationCode.tr(),
                    size: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                } else if (isresetPass!) ...{
                  AppText(
                    text: LocaleKeys.resetpass.tr(),
                    size: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                } else ...{
                  AppText(
                    text: LocaleKeys.welcome_back.tr(),
                    size: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  AppText(
                    text: LocaleKeys.please_login_to_your_account.tr(),
                    size: 14.sp,
                    color: Colors.white,
                  ),
                },
              ],
            ),
          ),
        ],
      ),
    );
  }
}
