// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';

class CustomProfileInformation extends StatelessWidget {
  const CustomProfileInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          width: 343.w,
          padding: EdgeInsets.all(16.r),
          margin: EdgeInsets.all(16.r),
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
              AppText(
                text: 'معلومات الحساب',
                color: AppColors.primary,
                size: 18.sp,
                fontWeight: FontWeight.bold,
                bottom: 14.h,
              ),
              const Divider(color: Color(0xffE0E0E0)),
              SizedBox(height: 10.h),
              Row(
                children: [
                  AppText(
                    text: 'البريد الالكتروني',
                    size: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 200.w,
                    child: AppText(
                      textAlign: TextAlign.end,
                      text: AppCubit.get(context).userMap["email"] ?? "",
                      size: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  AppText(
                    text: 'الهاتف',
                    size: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 200.w,
                    child: AppText(
                      textAlign: TextAlign.end,
                      text: AppCubit.get(context).userMap["phone"] ?? "",
                      size: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
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
