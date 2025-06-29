// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class EditProfileFields extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  const EditProfileFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
  });

  @override
  State<EditProfileFields> createState() => _EditProfileFieldsState();
}

class _EditProfileFieldsState extends State<EditProfileFields> {
  final FocusNode firstnameFocus = FocusNode();
  final FocusNode lastnameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode ageFocus = FocusNode();
  final FocusNode childIssueFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode confirmPassFocus = FocusNode();
  final FocusNode specialityFocus = FocusNode();
  final FocusNode levelFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    firstnameFocus.addListener(() => setState(() {}));
    lastnameFocus.addListener(() => setState(() {}));
    phoneFocus.addListener(() => setState(() {}));
    emailFocus.addListener(() => setState(() {}));
    ageFocus.addListener(() => setState(() {}));
    childIssueFocus.addListener(() => setState(() {}));
    passFocus.addListener(() => setState(() {}));
    confirmPassFocus.addListener(() => setState(() {}));
    specialityFocus.addListener(() => setState(() {}));
    levelFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    firstnameFocus.dispose();
    lastnameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    ageFocus.dispose();
    childIssueFocus.dispose();
    passFocus.dispose();
    confirmPassFocus.dispose();
    specialityFocus.dispose();
    levelFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              start: 18.w,
              text: LocaleKeys.edit_personal_information.tr(),
              size: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            Container(
              width: 343.w,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.sp),
              margin: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    spreadRadius: 1.r,
                    blurRadius: 5.r,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LocaleKeys.firstName.tr(),
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                    bottom: 8.h,
                    start: 16.w,
                  ),
                  AppInput(
                    enabledBorderColor: Colors.grey,
                    focusNode: firstnameFocus,
                    bottom: 16.h,
                    filled: true,
                    start: 5.w,
                    end: 5.w,
                    hint: LocaleKeys.firstName.tr(),
                    controller: widget.firstNameController,

                    prefixIcon: Icon(
                      Icons.person_outline,
                      color:
                          firstnameFocus.hasFocus
                              ? AppColors.primary
                              : Colors.grey,
                      size: 30.sp,
                    ),
                  ),
                  AppText(
                    text: LocaleKeys.lastName.tr(),
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                    bottom: 8.h,
                    start: 16.w,
                  ),
                  AppInput(
                    start: 5.w,
                    end: 5.w,
                    enabledBorderColor: Colors.grey,
                    focusNode: lastnameFocus,
                    bottom: 16.h,
                    filled: true,
                    hint: LocaleKeys.lastName.tr(),
                    controller: widget.lastNameController,

                    prefixIcon: Icon(
                      Icons.person_outline,
                      color:
                          lastnameFocus.hasFocus
                              ? AppColors.primary
                              : Colors.grey,
                      size: 30.sp,
                    ),
                  ),
                  AppText(
                    text: LocaleKeys.email.tr(),
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                    bottom: 8.h,
                    start: 16.w,
                  ),
                  AppInput(
                    start: 5.w,
                    end: 5.w,
                    enabledBorderColor: Colors.grey,
                    focusNode: emailFocus,
                    bottom: 16.h,
                    filled: true,
                    hint: LocaleKeys.email.tr(),
                    controller: widget.emailController,
                    inputType: TextInputType.emailAddress,

                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color:
                          emailFocus.hasFocus ? AppColors.primary : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// Widget _buildDropdownItem(Country country) => SizedBox(
//   width: 70.w,
//   child: FittedBox(
//     child: Row(
//       children: <Widget>[
//         CountryPickerUtils.getDefaultFlagImage(country),
//         // SizedBox(width: 8.w),
//         Text("+${country.phoneCode}(${country.isoCode})"),
//       ],
//     ),
//   ),
// );
