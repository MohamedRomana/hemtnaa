import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/screens/child_screens/doctor_view/widgets/custom_about_doctor.dart';
import '../../../../../core/widgets/custom_bottom_nav.dart';
import 'widgets/doctor_header.dart';

class DoctorView extends StatelessWidget {
  final int index;
  final bool isPost;
  const DoctorView({super.key, required this.index, required this.isPost});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                ProviderHeader(index: index, isPost: false,),
                CustomAboutDoctor(index: index),
              ],
            ),
          ),
        );
      },
    );
  }
}
