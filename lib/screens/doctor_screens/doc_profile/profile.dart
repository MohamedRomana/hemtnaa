import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/custom_doc_bottom_nav.dart';
import 'package:hemtnaa/core/widgets/custom_shimmer.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/login_first.dart';
import 'widgets/profile_container.dart';

class DocProfile extends StatefulWidget {
  const DocProfile({super.key});

  @override
  State<DocProfile> createState() => _DocProfileState();
}

class _DocProfileState extends State<DocProfile> {
  @override
  void initState() {
    AppCubit.get(context).showUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const CustomDocBottomNav(),
          body:
              CacheHelper.getUserToken() == ""
                  ? const LoginFirst()
                  :  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child:
                          state is ShowUserLoading
                              ? Column(
                                children: [
                                  SizedBox(height: 40.h),
                                  CustomShimmer(
                                    child: Container(
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
                                  ),
                                ],
                              )
                              : Column(
                                children: [
                                  SizedBox(height: 44.h),
                                  const ProfileContainer(),
                                  // const ChildProblemContainer(),
                                  // const ScoreContainer(),
                                ],
                              ),
                    ),
                  ),
        );
      },
    );
  }
}
