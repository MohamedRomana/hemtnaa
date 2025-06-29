import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_cached.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCubit.get(context).userMap["profile_picture"] == null
                  ? Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(100.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          spreadRadius: 1.r,
                          blurRadius: 5.r,
                          offset: Offset(0, 5.r),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.asset(
                        Assets.img.logo.path,
                        width: 80.w,
                        height: 80.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: AppCachedImage(
                      image:
                          AppCubit.get(context).userMap["profile_picture"] ??
                          "",
                      width: 100.w,
                      height: 100.w,
                      fit: BoxFit.cover,
                    ),
                  ),
              SizedBox(height: 12.h),
              SizedBox(
                width: 200.w,
                child: AppText(
                  text:
                      "${AppCubit.get(context).userMap["first_name"] ?? ""} ${AppCubit.get(context).userMap["last_name"] ?? ""}",
                  size: 18.sp,
                  color: const Color(0xff434343),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 200.w,
                child: AppText(
                  text: AppCubit.get(context).userMap["user_type"] ?? "",
                  bottom: 24.h,
                  size: 14.sp,
                  color: const Color(0xff434343),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 44.h,
                child: AppButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, const DocProfileEdit());
                  },
                  width: 312.w,
                  radius: 8.r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.edit, color: Colors.white),
                      AppText(
                        start: 5.w,
                        text: 'تعديل الحساب',
                        color: Colors.white,
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              Divider(color: const Color(0xffE0E0E0), thickness: 1.5.h),
              SizedBox(height: 22.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'المعلومات الشخصية',
                    color: AppColors.orange,
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                    bottom: 20.h,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'رقم الجوال',
                        color: const Color(0xff5E5E5E),
                        size: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 170.w,
                        child: AppText(
                          textAlign: TextAlign.end,
                          text: AppCubit.get(context).userMap["phone"] ?? "",
                          color: const Color(0xff5E5E5E),
                          size: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'البريد الالكتروني',
                        color: const Color(0xff5E5E5E),
                        size: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 180.w,
                        child: AppText(
                          textAlign: TextAlign.end,
                          text: AppCubit.get(context).userMap["email"] ?? "",
                          color: const Color(0xff5E5E5E),
                          size: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'التخصص',
                        color: const Color(0xff5E5E5E),
                        size: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 170.w,
                        child: AppText(
                          textAlign: TextAlign.end,
                          text:
                              AppCubit.get(
                                context,
                              ).userMap["doctor_specialty"] ??
                              "",
                          color: const Color(0xff5E5E5E),
                          size: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
