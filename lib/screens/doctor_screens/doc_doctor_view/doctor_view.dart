import 'package:flutter/material.dart';
import 'package:hemtnaa/screens/child_screens/doctor_view/widgets/custom_about_doctor.dart';
import '../../../core/widgets/custom_doc_bottom_nav.dart';
import 'widgets/doctor_header.dart';

class CustomDoctorView extends StatelessWidget {
  final int index;
  const CustomDoctorView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomDocBottomNav(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [const ProviderHeader(), CustomAboutDoctor(index: index)],
        ),
      ),
    );
  }
}
