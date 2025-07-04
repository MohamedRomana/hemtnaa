import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_cached.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../profile/profile.dart';

class CustomChildScore extends StatelessWidget {
  const CustomChildScore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => current is ActivityScoreChanged,
      builder: (context, state) {
        final score = AppCubit.get(context).activityScore;
        final progress = (score / 100).clamp(0.0, 1.0);
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
              top: 20.h,
            ),
            child: Row(
              children: [
                AppCubit.get(context).userMap["profile_picture"] == null
                    ? Container(
                      height: 48.w,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.2),
                            spreadRadius: 1.r,
                            blurRadius: 5.r,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          Assets.img.logo.path,
                          height: 48.w,
                          width: 48.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: AppCachedImage(
                        image:
                            AppCubit.get(context).userMap["profile_picture"] ??
                            "",
                        height: 48.w,
                        width: 48.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'اكتمل $score%',
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: 150.w,
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(8.r),
                        value: progress,
                        minHeight: 10,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xff24B600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
