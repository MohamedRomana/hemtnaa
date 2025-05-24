import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/custom_bottom_nav.dart';
import 'package:hemtnaa/screens/child_screens/drawer/drawer.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'widgets/child_problem_container.dart';
import 'widgets/profile_container.dart';
import 'widgets/score_container.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
          body: const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  ProfileContainer(),
                  ChildProblemContainer(),
                  ScoreContainer(),
                  SizedBox(height: 120),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
