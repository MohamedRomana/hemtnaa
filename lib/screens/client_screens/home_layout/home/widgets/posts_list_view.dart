import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import 'posts_views.dart';

class PostsListView extends StatelessWidget {
  const PostsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: 20,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder:
          (context, index) => Container(
            width: 343.w,
            padding: EdgeInsetsDirectional.only(
              start: 12.w,
              top: 12.h,
              bottom: 12.h,
            ),
            decoration: BoxDecoration(
              color:
                  index.isEven
                      ? const Color(0xffFFF5DF)
                      : const Color(0xffDFEBFF),
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
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1000.r),
                      child: Image.asset(
                        Assets.img.doctor2.path,
                        height: 44.w,
                        width: 44.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: AppText(
                            start: 8.w,
                            text: 'د/عمرو',
                            size: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 200.w,
                          child: AppText(
                            start: 8.w,
                            text: 'منذ ساعتين',
                            size: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 300.w,
                  child: AppText(
                    top: 20.h,
                    textAlign: TextAlign.start,
                    text:
                        'تحدث مع الطفل بوضوح وصبر - شاركه ألعاب وأنشطة تعزز الكلمات والحروف.',
                    lines: 2,
                    fontWeight: FontWeight.w600,
                    size: 12.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 90.h,
                  child: ListView.separated(
                    padding: EdgeInsetsDirectional.only(top: 16.h, end: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    separatorBuilder: (context, index) => SizedBox(width: 8.w),
                    itemBuilder:
                        (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            Assets.img.images1.path,
                            height: 90.w,
                            width: 90.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                  ),
                ),
                SizedBox(height: 16.h),
                PostsViews(index: index),
              ],
            ),
          ),
    );
  }
}
