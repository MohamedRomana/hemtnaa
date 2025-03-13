import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_shimmer.dart';

class VideosShimmerLoading extends StatelessWidget {
  const VideosShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsetsDirectional.only(top: 16.h, end: 16.w),
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      separatorBuilder: (context, index) => SizedBox(width: 8.w),
      itemBuilder:
          (context, index) => CustomShimmer(
            child: Container(
              height: 90.w,
              width: 90.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
    );
  }
}
