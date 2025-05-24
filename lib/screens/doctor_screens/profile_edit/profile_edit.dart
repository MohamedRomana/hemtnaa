// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/gen/assets.gen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/custom_doc_bottom_nav.dart';
import 'widgets/edit_profile_fields.dart';

final _firstNameController = TextEditingController();
final _phoneController = TextEditingController();
final _passController = TextEditingController();

class DocProfileEdit extends StatelessWidget {
  const DocProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const CustomDocBottomNav(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 120.h),
                AppCubit.get(context).profileImage.isEmpty
                    ? InkWell(
                      onTap:
                          () => AppCubit.get(context).getProfileImage(context),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Image.asset(
                              Assets.img.doctor2.path,
                              height: 120.h,
                              width: 120.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          PositionedDirectional(
                            end: 0,
                            child: Icon(
                              Icons.edit_square,
                              color: AppColors.primary,
                              size: 25.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                    : Stack(
                      children: [
                        Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(
                                AppCubit.get(context).profileImage.first,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          child: InkWell(
                            onTap:
                                () =>
                                    AppCubit.get(context).removeProfileImage(),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                SizedBox(height: 20.h),
                EditProfileFields(
                  passController: _passController,
                  phoneController: _phoneController,
                  firstNameController: _firstNameController,
                ),

                SizedBox(height: 150.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
