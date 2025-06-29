import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/contsants.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_cached.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../home_layout/chats/chat_details/chat_details.dart';

class ProviderHeader extends StatefulWidget {
  final int index;
  final bool isPost;
  const ProviderHeader({super.key, required this.index, required this.isPost});

  @override
  State<ProviderHeader> createState() => _ProviderHeaderState();
}

class _ProviderHeaderState extends State<ProviderHeader> {
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
                  child:
                      AppCubit.get(context).doctorsList[widget
                                      .index]['profile_picture'] ==
                                  null ||
                              AppCubit.get(context).doctorsList[widget
                                  .index]['doctor_image']
                          ? Container(
                            height: 150.w,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(150.r),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withAlpha(100),
                                  blurRadius: 5.r,
                                  spreadRadius: 1.r,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(150.r),
                              child: Image.asset(
                                Assets.img.logo.path,
                                height: 150.w,
                                width: 150.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(150.r),
                            child: AppCachedImage(
                              image:
                                  widget.isPost == true
                                      ? AppCubit.get(context).doctorsList[widget
                                          .index]['doctor_image']
                                      : AppCubit.get(context).doctorsList[widget
                                              .index]['profile_picture'] ??
                                          "",
                              height: 150.w,
                              width: 150.w,
                              fit: BoxFit.cover,
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
              text:
                  widget.isPost == true
                      ? AppCubit.get(context).postsList[widget
                              .index]['doctor_name'] ??
                          ""
                      : "${AppCubit.get(context).doctorsList[widget.index]['first_name']} ${AppCubit.get(context).doctorsList[widget.index]['last_name']}",
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
                makePhoneCall(
                  widget.isPost == true
                      ? AppCubit.get(context).postsList[widget
                              .index]['doctor_phone'] ??
                          ""
                      : AppCubit.get(context).doctorsList[widget
                              .index]['phone'] ??
                          "",
                );
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
                socketService.joinRoom("room_1");
                AppRouter.navigateAndFinish(context, const ChatDetails());
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
