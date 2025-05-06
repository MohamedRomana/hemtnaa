import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../doc_chat_details/doc_chat_details.dart';

class DocChatList extends StatelessWidget {
  const DocChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      itemCount: 20,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder:
          (context, index) => InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const DocChatDetails());
            },
            child: Container(
              width: 343.w,
              padding: EdgeInsets.all(16.r),
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
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Image.asset(
                      Assets.img.doctor.path,
                      height: 48.w,
                      width: 48.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 130.w,
                            child: AppText(
                              text: 'احمد محمد',
                              size: 18.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 120.w,
                            child: AppText(
                              textAlign: TextAlign.start,
                              text: '8:00 صباحًا',
                              start: 50.w,
                              size: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 200.w,
                        child: AppText(
                          text: 'مرحبًا يا بطل! 😊 كيف حالك اليوم؟ ',
                          size: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
