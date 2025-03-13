import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/custom_bottom_nav.dart';
import 'widgets/child_problem_container.dart';
import 'widgets/profile_container.dart';
import 'widgets/score_container.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const CustomBottomNav(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 44.h),
                  const ProfileContainer(),
                  const ChildProblemContainer(),
                  const ScoreContainer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


