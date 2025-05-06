import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../child_profile/child_profile.dart';
import 'widgets/add_activity.dart';
import 'widgets/custom_child_rate.dart';

final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _statusController = TextEditingController();
final _startDateController = TextEditingController();
final _endDateController = TextEditingController();
final _descriptionController = TextEditingController();

final class DocRates extends StatelessWidget {
  const DocRates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
            ),
          );
        },
        mini: true,
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, size: 24.sp, color: Colors.white),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 60.h, bottom: 30.h),
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder:
            (context, index) => InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppRouter.navigateTo(context, const ChildProfile());
              },
              child: Container(
                width: 343.w,
                padding: EdgeInsets.all(16.r),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      spreadRadius: 1.r,
                      blurRadius: 5.r,
                      offset: Offset(0, 5.r),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000.r),
                          child: Image.asset(
                            Assets.img.man.path,
                            height: 50.w,
                            width: 50.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        AppText(
                          text: 'احمد محمد',
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                          start: 8.w,
                        ),
                      ],
                    ),
                    const Spacer(),
                    const CustomChildRate(),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
