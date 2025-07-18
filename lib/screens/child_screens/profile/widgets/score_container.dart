import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';

class ScoreContainer extends StatelessWidget {
  const ScoreContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => current is ActivityScoreChanged,

      builder: (context, state) {
        final score = AppCubit.get(context).activityScore;
        final progress = (score / 100).clamp(0.0, 1.0);
        return Container(
          width: 343.w,
          padding: EdgeInsets.all(16.r),
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                spreadRadius: 1.r,
                blurRadius: 5.r,
                offset: Offset(0, 5.r),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.w,
                child: AppText(
                  text: 'الهدف',
                  size: 18.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 14.h,
                  color: AppColors.primary,
                ),
              ),
              const Divider(color: Color(0xffE0E0E0)),
              SizedBox(height: 24.h),
              LinearProgressIndicator(
                borderRadius: BorderRadius.circular(8.r),
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xff24B600),
                ),
              ),
              SizedBox(
                width: 150.w,
                child: AppText(
                  bottom: 15.h,
                  top: 7.h,
                  text: " $score%",
                  size: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: AppText(
                      text:
                          score <= 20
                              ? "ضعيف"
                              : score <= 50
                              ? "متوسط"
                              : "ممتاز",
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: AppText(
                      text: 'الهدف: $score%',
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
