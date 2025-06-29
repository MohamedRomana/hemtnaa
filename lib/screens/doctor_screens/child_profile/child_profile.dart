import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import 'package:hemtnaa/core/widgets/custom_doc_bottom_nav.dart';
import '../../../gen/assets.gen.dart';
import '../home_layout/doc_rates/widgets/add_activity.dart';
import 'widgets/custom_about_child.dart';
import 'widgets/custom_child_header.dart';
import 'widgets/custom_rate_child.dart';

final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _statusController = TextEditingController();
final _startDateController = TextEditingController();
final _endDateController = TextEditingController();
final _descriptionController = TextEditingController();
final _childNameController = TextEditingController();

class ChildProfile extends StatelessWidget {
  const ChildProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomDocBottomNav(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomChildHeader(),
            const CustomAboutChild(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Row(
                  children: [
                    AppText(
                      text: 'الانشطه التي قام بها',
                      size: 24.sp,
                      start: 16.w,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsetsDirectional.only(end: 16.w),
                      onPressed: () {
                        AppRouter.navigateTo(
                          context,
                          AddActivity(
                            nameController: _nameController,
                            statusController: _statusController,
                            endDateController: _endDateController,
                            startDateController: _startDateController,
                            descriptionController: _descriptionController,
                            formKey: _formKey,
                            childNameController: _childNameController,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add_task_outlined,
                        size: 30.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                ListView.separated(
                  padding: EdgeInsetsDirectional.only(top: 16.h, bottom: 30.h),
                  itemCount: 20,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder:
                      (context, index) => Container(
                        width: 343.w,
                        padding: EdgeInsets.all(16.r),
                        margin: EdgeInsetsDirectional.symmetric(
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.2),
                              blurRadius: 5.r,
                              spreadRadius: 1.r,
                              offset: Offset(0, 5.r),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000.r),
                              child: Image.asset(
                                Assets.img.pazzel.path,
                                height: 50.w,
                                width: 50.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: 'بازل',
                                  size: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                AppText(
                                  text: 'الهدف 90%',
                                  size: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            const Spacer(),
                            const CustomRateChild(),
                          ],
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
