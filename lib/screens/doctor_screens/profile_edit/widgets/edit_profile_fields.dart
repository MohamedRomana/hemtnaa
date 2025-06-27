// ignore_for_file: deprecated_member_use
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/screens/doctor_screens/profile_edit/profile_edit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class EditProfileFields extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passController;
  const EditProfileFields({
    super.key,
    required this.passController,
    required this.phoneController,
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
                    text: LocaleKeys.phone.tr(),
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                    bottom: 8.h,
                    start: 16.w,
                  ),
                  AppInput(
                    start: 5.w,
                    end: 5.w,
                    enabledBorderColor: Colors.grey,
                    focusNode: phoneFocus,
                    bottom: 16.h,
                    filled: true,
                    hint: LocaleKeys.phone.tr(),
                    controller: widget.phoneController,
                    inputType: TextInputType.phone,
                    prefixIcon: SizedBox(
                      width: 130.w,
                      child: FittedBox(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 16.w),
                              child: CountryPickerDropdown(
                                initialValue: 'EG',
                                itemBuilder: _buildDropdownItem,
                                sortComparator:
                                    (Country a, Country b) =>
                                        a.isoCode.compareTo(b.isoCode),
                                onValuePicked: (Country country) {
                                  profileEditPhoneCode = country.phoneCode;
                                  debugPrint(profileEditPhoneCode);
                                },
                              ),
                            ),
                            Container(
                              height: 24.h,
                              width: 1.w,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.phone_outlined,
                              color:
                                  phoneFocus.hasFocus
                                      ? AppColors.primary
                                      : Colors.grey,
                            ),
                          ],
                        ),
                      ),
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
                  AppText(
                    text: LocaleKeys.password.tr(),
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                    bottom: 8.h,
                    start: 16.w,
                  ),
                  BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      return AppInput(
                        start: 5.w,
                        end: 5.w,
                        filled: true,
                        focusNode: passFocus,
                        focusedBorderColor: AppColors.primary,
                        hint: LocaleKeys.password.tr(),
                        enabledBorderColor: Colors.grey,
                        controller: widget.passController,

                        prefixIcon: Icon(
                          Icons.lock,
                          color:
                              passFocus.hasFocus
                                  ? AppColors.primary
                                  : Colors.grey,
                          size: 25.sp,
                        ),
                        secureText: AppCubit.get(context).isSecureLogIn,
                        suffixIcon:
                            AppCubit.get(context).isSecureLogIn
                                ? InkWell(
                                  onTap: () {
                                    AppCubit.get(
                                      context,
                                    ).isSecureLogInIcon(false);
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.h),
                                    child: Icon(
                                      Icons.visibility_off,
                                      color:
                                          passFocus.hasFocus
                                              ? AppColors.primary
                                              : Colors.grey,
                                      size: 21.sp,
                                    ),
                                  ),
                                )
                                : InkWell(
                                  onTap: () {
                                    AppCubit.get(
                                      context,
                                    ).isSecureLogInIcon(true);
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.h),
                                    child: Icon(
                                      Icons.visibility,
                                      color:
                                          passFocus.hasFocus
                                              ? AppColors.primary
                                              : Colors.grey,
                                      size: 21.sp,
                                    ),
                                  ),
                                ),
                      );
                    },
                  ),
                  BlocConsumer<AppCubit, AppState>(
                    listener: (context, state) {
                      // if (state is UpdateUserSuccess) {
                      //   AppRouter.pop(context);
                      //   showFlashMessage(
                      //     message: state.message,
                      //     type: FlashMessageType.success,
                      //     context: context,
                      //   );
                      //   widget.firstNameController.clear();
                      //   widget.phoneController.clear();
                      //   widget.passController.clear();
                      // } else if (state is UpdateUserFailure) {
                      //   showFlashMessage(
                      //     message: state.error,
                      //     type: FlashMessageType.error,
                      //     context: context,
                      //   );
                      // }
                    },
                    builder: (context, state) {
                      return AppButton(
                        elevation: WidgetStatePropertyAll(3.r),
                        shadowColor: const WidgetStatePropertyAll(
                          AppColors.primary,
                        ),
                        top: 24.h,
                        width: 311.w,
                        onPressed: () {
                          // AppCubit.get(context).updateUser(
                          //   password: _passController.text,
                          //   firstName: _firstNameController.text.isEmpty
                          //       ? AppCubit.get(context)
                          //           .showUserModel["first_name"]
                          //       : _firstNameController.text,

                          //   phone: _phoneController.text.isEmpty
                          //       ? AppCubit.get(context)
                          //           .showUserModel["phone"]
                          //       : _phoneController.text,

                          // );
                        },
                        child:
                            state is UploadImagesLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : AppText(
                                  text: LocaleKeys.save.tr(),
                                  size: 21.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                      );
                    },
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

Widget _buildDropdownItem(Country country) => SizedBox(
  width: 70.w,
  child: FittedBox(
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        // SizedBox(width: 8.w),
        Text("+${country.phoneCode}(${country.isoCode})"),
      ],
    ),
  ),
);
