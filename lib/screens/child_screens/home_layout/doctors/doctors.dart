import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import 'package:hemtnaa/core/widgets/app_cached.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import 'package:hemtnaa/core/widgets/custom_app_bar.dart';
import 'package:hemtnaa/core/widgets/custom_lottie_widget.dart';
import 'package:hemtnaa/screens/child_screens/doctor_view/doctor_view.dart';
import 'package:hemtnaa/screens/child_screens/home_layout/home/widgets/posts_list_shimmer.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/login_first.dart';
import '../../../../gen/assets.gen.dart';
import '../../drawer/drawer.dart';

class Doctors extends StatefulWidget {
  const Doctors({super.key});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  @override
  void initState() {
    AppCubit.get(context).getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: const CustomDrawer(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.h),
            child: CustomAppBar(scaffoldKey: scaffoldKey, title: 'الاطباء'),
          ),
          body:
              CacheHelper.getUserToken() == ""
                  ? const LoginFirst()
                  : AppCubit.get(context).doctorsList.isEmpty
                  ? CustomLottieWidget(lottieName: Assets.img.emptyorder)
                  : state is GetUsersLoading
                  ? const PostsListShimmer()
                  : ListView.separated(
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 16.h,
                      top: 16.h,
                      bottom: 120.h,
                    ),
                    separatorBuilder:
                        (context, index) => SizedBox(height: 16.h),
                    itemCount: AppCubit.get(context).doctorsList.length,
                    itemBuilder:
                        (context, index) => InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppRouter.navigateTo(
                              context,
                              DoctorView(index: index, isPost: false),
                            );
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
                                AppCubit.get(
                                          context,
                                        ).doctorsList[index]['profile_picture'] ==
                                        null
                                    ? Container(
                                      height: 60.w,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          150.r,
                                        ),
                                        border: Border.all(
                                          color: AppColors.primary,
                                          width: 2.w,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary.withAlpha(
                                              100,
                                            ),
                                            blurRadius: 5.r,
                                            spreadRadius: 1.r,
                                            offset: const Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          150.r,
                                        ),
                                        child: Image.asset(
                                          Assets.img.logo.path,
                                          height: 60.w,
                                          width: 60.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                    : ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        150.r,
                                      ),
                                      child: AppCachedImage(
                                        image:
                                            AppCubit.get(
                                              context,
                                            ).doctorsList[index]['profile_picture'] ??
                                            "",
                                        height: 60.w,
                                        width: 60.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text:
                                          "${AppCubit.get(context).doctorsList[index]['first_name']}  ${AppCubit.get(context).doctorsList[index]['last_name']}",
                                      size: 18.sp,
                                      color: AppColors.primary,
                                    ),
                                    AppText(
                                      text:
                                          AppCubit.get(
                                            context,
                                          ).doctorsList[index]['doctor_specialty'] ??
                                          "",
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
      },
    );
  }
}
