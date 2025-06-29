// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_cached.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import 'package:hemtnaa/gen/assets.gen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../profile_edit/profile_edit.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          width: 343.w,
          padding: EdgeInsets.all(16.r),
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80.w,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      spreadRadius: 1.r,
                      blurRadius: 5.r,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child:
                    AppCubit.get(context).userMap['profile_picture'] == null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Image.asset(
                            Assets.img.logo.path,
                            height: 80.w,
                            width: 80.w,
                            fit: BoxFit.cover,
                          ),
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: AppCachedImage(
                            image:
                                AppCubit.get(
                                  context,
                                ).userMap['profile_picture'] ??
                                "",
                            height: 80.w,
                            width: 80.w,
                            fit: BoxFit.cover,
                          ),
                        ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: AppText(
                      text:
                          "${AppCubit.get(context).userMap['first_name'] ?? ""} ${AppCubit.get(context).userMap['last_name'] ?? ""} ",
                      size: 16.sp,
                      color: const Color(0xff434343),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: AppText(
                      text:
                          AppCubit.get(context).userMap['user_type'] == "parent"
                              ? "child"
                              : "",
                      bottom: 16.h,
                      size: 18.sp,
                      color: const Color(0xff434343),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 44.h,
                    child: AppButton(
                      onPressed: () {
                        AppRouter.navigateTo(context, const ProfileEdit());
                      },
                      elevation: WidgetStatePropertyAll(3.r),
                      shadowColor: const WidgetStatePropertyAll(
                        AppColors.primary,
                      ),
                      width: 200.w,
                      radius: 100.r,
                      borderColor: AppColors.primary,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.edit, color: AppColors.primary),
                          AppText(
                            start: 5.w,
                            text: 'تعديل الحساب',
                            color: AppColors.primary,
                            size: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
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
