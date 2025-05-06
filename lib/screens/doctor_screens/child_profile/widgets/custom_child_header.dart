import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/contsants.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../home_layout/doc_chat/doc_chat_details/doc_chat_details.dart';

class CustomChildHeader extends StatelessWidget {
  const CustomChildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(250.r),
                bottomStart: Radius.circular(250.r),
              ),
              border: Border.all(color: AppColors.primary, width: 7.w),
            ),
          ),
          Container(
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary,
              border: Border.symmetric(
                vertical: BorderSide(color: AppColors.primary, width: 7.w),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(top: 50.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Image.asset(
                      Assets.img.man.path,
                      height: 150.w,
                      width: 150.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 100.h,
            start: 140.w,
            child: AppText(
              bottom: 16.h,
              top: 16.h,
              text: 'اسم الطفل',
              size: 24.sp,
              color: Colors.white,
            ),
          ),
          PositionedDirectional(
            bottom: 50.h,
            end: MediaQuery.of(context).size.width / 2 + 60.w,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                makePhoneCall('01000000000');
              },
              child: Container(
                height: 60.w,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 2.r),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call, color: Colors.red, size: 24.sp),
                    const AppText(
                      text: 'Call',
                      color: Colors.red,
                      family: FontFamily.lexendBold,
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 50.h,
            start: MediaQuery.of(context).size.width / 2 + 60.w,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppRouter.navigateAndFinish(context, const DocChatDetails());
              },
              child: Container(
                height: 60.w,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 2.r),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat, color: Colors.green, size: 24.sp),
                    const AppText(
                      text: 'Chat',
                      color: Colors.green,
                      family: FontFamily.lexendBold,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
