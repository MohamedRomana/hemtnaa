import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import 'package:hemtnaa/core/widgets/custom_app_bar.dart';
import 'package:hemtnaa/screens/child_screens/doctor_view/doctor_view.dart';
import '../../../../gen/assets.gen.dart';
import '../../drawer/drawer.dart';

class Doctors extends StatelessWidget {
  const Doctors({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: CustomAppBar(scaffoldKey: scaffoldKey, title: 'الاطباء',),
      ),
      body: ListView.separated(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.h,
          top: 16.h,
          bottom: 120.h,
        ),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemCount: 10,
        itemBuilder:
            (context, index) => InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppRouter.navigateTo(context, const DoctorView());
              },
              child: Container(
                width: 343.w,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: const Color(0xffF6F6F8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryLight.withAlpha(100),
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 5.r),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(150.r),
                      child: Image.asset(
                        Assets.img.doctor.path,
                        height: 60.w,
                        width: 60.w,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'د/ احمد محمد',
                          size: 18.sp,
                          color: AppColors.primary,
                        ),
                        RatingBar.readOnly(
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          initialRating: 3,
                          maxRating: 5,
                          isHalfAllowed: true,
                          halfFilledIcon: Icons.star_half,
                          size: 18.sp,
                        ),
                        AppText(
                          text: 'طبيب جبنه',
                          size: 14.sp,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
