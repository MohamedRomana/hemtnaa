import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../gen/fonts.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../constants/colors.dart';
import 'app_cached.dart';
import 'app_text.dart';

class ServiceItem extends StatelessWidget {
  final void Function() onTap;
  final String serviceName;
  final String categoryName;
  final String price;
  final String image;

  const ServiceItem({
    super.key,
    required this.onTap,
    required this.serviceName,
    required this.categoryName,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: 343.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryLight,
              blurRadius: 5.r,
              spreadRadius: 1.r,
              offset: Offset(0, 5.r),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 48.w,
              width: 48.w,
              margin: EdgeInsetsDirectional.only(end: 8.w),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryLight,
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: AppCachedImage(image: image),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.w,
                  child: AppText(
                    text: serviceName,
                    size: 14.sp,
                    bottom: 8.h,
                    lines: 2,
                  ),
                ),
                SizedBox(
                  width: 250.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            '',
                            width: 12.w,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 130.w,
                            child: AppText(
                              start: 3.w,
                              text: categoryName,
                              size: 12.sp,
                              lines: 2,
                              color: const Color(0xffA4A4AA),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AppText(
                            text: "${LocaleKeys.price.tr()}: ",
                            size: 12.sp,
                          ),
                          AppText(
                            text: price,
                            color: AppColors.priceColor,
                            family: FontFamily.poppinsMedium,
                          ),
                          AppText(
                            text: " ${LocaleKeys.sar.tr()}",
                            size: 14.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
