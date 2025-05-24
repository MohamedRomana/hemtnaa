import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/custom_doc_bottom_nav.dart';
import 'widgets/profile_container.dart';

class DocProfile extends StatelessWidget {
  const DocProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const CustomDocBottomNav(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
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
