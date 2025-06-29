import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';

class CustomAboutDoctor extends StatelessWidget {
  final int index;
  const CustomAboutDoctor({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          width: 343.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.r,
                spreadRadius: 1.r,
                offset: Offset(0, 5.r),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  AppText(
                    text: 'اسم الدكتور',
                    family: FontFamily.lexendBold,
                    size: 16.sp,
                  ),
                  const Spacer(),
                  AppText(
                    text:
                        "${AppCubit.get(context).doctorsList[index]["first_name"]} ${AppCubit.get(context).doctorsList[index]["last_name"]}",
                    family: FontFamily.lexendBold,
                    size: 16.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              const Divider(color: Colors.grey),
              SizedBox(height: 8.h),

              Row(
                children: [
                  AppText(
                    text: 'تخصص الدكتور',
                    family: FontFamily.lexendBold,
                    size: 16.sp,
                  ),
                  const Spacer(),
                  AppText(
                    text:
                        AppCubit.get(
                          context,
                        ).doctorsList[index]["doctor_specialty"],
                    family: FontFamily.lexendBold,
                    size: 16.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              const Divider(color: Colors.grey),
              SizedBox(height: 8.h),
              Row(
                children: [
                  AppText(
                    text: 'البريد الالكتروني',
                    family: FontFamily.lexendBold,
                    size: 16.sp,
                  ),
                  const Spacer(),
                  AppText(
                    text:
                        AppCubit.get(context).doctorsList[index]["email"] ?? "",
                    family: FontFamily.lexendBold,
                    size: 14.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              const Divider(color: Colors.grey),
              SizedBox(height: 8.h),

              Row(
                children: [
                  AppText(
                    text: 'الهاتف',
                    family: FontFamily.lexendBold,
                    size: 16.sp,
                  ),
                  const Spacer(),
                  AppText(
                    text:
                        AppCubit.get(context).doctorsList[index]["phone"] ?? "",
                    family: FontFamily.lexendBold,
                    size: 16.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }
}
