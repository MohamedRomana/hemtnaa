import 'package:flutter/material.dart';
import 'package:hemtnaa/screens/child_screens/doctor_view/widgets/custom_about_doctor.dart';
import '../../../../../core/widgets/custom_bottom_nav.dart';
import 'widgets/doctor_header.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomBottomNav(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(children: [ProviderHeader(), CustomAboutDoctor()]),
      ),
    );
  }
}
