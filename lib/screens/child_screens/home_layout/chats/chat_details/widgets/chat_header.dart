import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/widgets/app_router.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../widgets/call.dart';

class ChatHeader extends StatelessWidget {
  final VoidCallback onChangeBackground;

  const ChatHeader({super.key, required this.onChangeBackground});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          decoration: const BoxDecoration(color: Color(0xffFAFAFA)),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000.r),
                child: Image.asset(
                  Assets.img.doctor2.path,
                  height: 40.w,
                  width: 40.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: AppText(
                      text: 'احمد محمد',
                      size: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: AppText(
                      text: '8:00 صباحًا',
                      size: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppRouter.navigateTo(
                        context,
                        const CallPage(callID: '123'),
                      );
                    },
                    child: SvgPicture.asset(
                      Assets.svg.phone,
                      height: 24.h,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppRouter.navigateTo(
                        context,
                        const CallVideoPage(callID: '123'),
                      );
                    },
                    child: SvgPicture.asset(
                      Assets.svg.videoCall,
                      height: 24.h,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  PopupMenuButton<int>(
                    color: Colors.white,
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                    onSelected: (value) {
                      if (value == 1) onChangeBackground();
                    },
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: AppText(
                              text: 'تغيير الخلفيه',
                              size: 16.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
