// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/custom_bottom_nav.dart';
import 'package:hemtnaa/screens/child_screens/drawer/drawer.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_shimmer.dart';
import '../../../core/widgets/login_first.dart';
import 'widgets/child_problem_container.dart';
import 'widgets/custom_profile_information.dart';
import 'widgets/profile_container.dart';
import 'widgets/score_container.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override

  void initState() {
    AppCubit.get(context).showUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          skey: scaffoldKey,
          drawer: const CustomDrawer(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.h),
            child: CustomAppBar(
              scaffoldKey: scaffoldKey,
              title: 'الملف الشخصي',
              isHome: true,
            ),
          ),
          body:
              CacheHelper.getUserToken() == ""
                  ? const LoginFirst()
                  : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child:
                        state is ShowUserLoading
                            ? Column(
                              children: [
                                SizedBox(height: 40.h),
                                CustomShimmer(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 500.h,
                                        width: 343.w,
                                        margin: EdgeInsets.all(16.r),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            15.r,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary
                                                  .withOpacity(0.2),
                                              spreadRadius: 1.r,
                                              blurRadius: 5.r,
                                              offset: Offset(0, 5.r),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 500.h,
                                        width: 343.w,
                                        margin: EdgeInsets.all(16.r),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            15.r,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary
                                                  .withOpacity(0.2),
                                              spreadRadius: 1.r,
                                              blurRadius: 5.r,
                                              offset: Offset(0, 5.r),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                            : Center(
                              child: Column(
                                children: [
                                  const ProfileContainer(),
                                  Container(
                                    width: 343.w,
                                    padding: EdgeInsets.all(16.r),
                                    margin: EdgeInsets.all(16.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withOpacity(
                                            0.2,
                                          ),
                                          spreadRadius: 1.r,
                                          blurRadius: 5.r,
                                          offset: Offset(0, 5.r),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: 'نبذة شخصية',
                                          color: AppColors.primary,
                                          size: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          bottom: 14.h,
                                        ),
                                        const Divider(color: Color(0xffE0E0E0)),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            AppText(
                                              text: 'التعليم',
                                              size: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: 200.w,
                                              child: AppText(
                                                textAlign: TextAlign.end,
                                                text:
                                                    AppCubit.get(
                                                      context,
                                                    ).userMap['child_education_level'] ??
                                                    "",
                                                size: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            AppText(
                                              text: 'حالة الطفل',
                                              size: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: 200.w,
                                              child: AppText(
                                                textAlign: TextAlign.end,
                                                text:
                                                    AppCubit.get(
                                                      context,
                                                    ).userMap['child_problem'] ??
                                                    "",
                                                size: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            AppText(
                                              text: 'تاريخ الميلاد',
                                              size: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: 200.w,
                                              child: AppText(
                                                textAlign: TextAlign.end,
                                                text:
                                                    AppCubit.get(
                                                      context,
                                                    ).userMap['child_birthdate'] ??
                                                    "",
                                                size: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const CustomProfileInformation(),
                                  const ChildProblemContainer(),
                                  const ScoreContainer(),
                                  const SizedBox(height: 120),
                                ],
                              ),
                            ),
                  ),
        );
      },
    );
  }
}
