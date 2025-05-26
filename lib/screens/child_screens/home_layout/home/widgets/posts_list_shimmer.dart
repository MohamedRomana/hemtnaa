import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/custom_shimmer.dart';

class PostsListShimmer extends StatelessWidget {
  const PostsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        padding: EdgeInsetsDirectional.only(
          start: 24.w,
          end: 24.w,
          bottom: 120.h,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder:
            (context, index) => Container(
              height: 150.h,
              width: 343.w,
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
            ),
      ),
    );
  }
}
