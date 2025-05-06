import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../profile/profile.dart';

class CustomChildScore extends StatelessWidget {
  const CustomChildScore({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        AppRouter.navigateTo(context, const Profile());
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 24.w,
          bottom: 35.h,
        ),
        child: Row(
          children: [
            Image.asset(
              Assets.img.man.path,
              height: 48.w,
              width: 48.w,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'اكتمل40%',
                  size: 14.sp,
                  color: AppColors.primary,
                ),
                AppText(text: 'سهل', size: 14.sp, color: AppColors.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
