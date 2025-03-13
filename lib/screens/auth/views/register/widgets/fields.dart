import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../data/auth_cubit.dart';

class CustomUserRegisterFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;

  const CustomUserRegisterFields({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.passController,
    required this.confirmPassController,
    required this.fullNameController, required this.emailController,
  });

  @override
  State<CustomUserRegisterFields> createState() =>
      _CustomUserRegisterFieldsState();
}

class _CustomUserRegisterFieldsState extends State<CustomUserRegisterFields> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode confirmPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    nameFocus.addListener(() => setState(() {}));
    phoneFocus.addListener(() => setState(() {}));
    emailFocus.addListener(() => setState(() {}));
    passFocus.addListener(() => setState(() {}));
    confirmPassFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    confirmPassFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),

              AppInput(
                enabledBorderColor: Colors.grey,
                focusNode: nameFocus,
                bottom: 18.h,
                filled: true,
                hint: LocaleKeys.fullName.tr(),
                controller: widget.fullNameController,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.nameValidate.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: nameFocus.hasFocus ? AppColors.primary : Colors.grey,
                  size: 30.sp,
                ),
              ),

              AppInput(
                enabledBorderColor: Colors.grey,
                focusNode: phoneFocus,
                bottom: 18.h,
                filled: true,
                hint: LocaleKeys.phone.tr(),
                controller: widget.phoneController,
                inputType: TextInputType.phone,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.phoneValidate.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(
                  Icons.phone_outlined,
                  color: phoneFocus.hasFocus ? AppColors.primary : Colors.grey,
                ),
              ),

              AppInput(
                enabledBorderColor: Colors.grey,
                focusNode: emailFocus,
                bottom: 18.h,
                filled: true,
                hint: LocaleKeys.email.tr(),
                controller: widget.emailController,
                inputType: TextInputType.emailAddress,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.yourEmailValidate.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: emailFocus.hasFocus ? AppColors.primary : Colors.grey,
                ),
              ),

              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return AppInput(
                    enabledBorderColor: Colors.grey,
                    focusNode: passFocus,
                    filled: true,
                    bottom: 18.h,
                    hint: LocaleKeys.password.tr(),
                    controller: widget.passController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.passwordValidate.tr();
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color:
                          passFocus.hasFocus ? AppColors.primary : Colors.grey,
                    ),
                    secureText: AuthCubit.get(context).isSecureRegister1,
                    suffixIcon:
                        AuthCubit.get(context).isSecureRegister1
                            ? InkWell(
                              onTap: () {
                                AuthCubit.get(
                                  context,
                                ).isSecureRegisterIcon1(false);
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
                                AuthCubit.get(
                                  context,
                                ).isSecureRegisterIcon1(true);
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

              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return AppInput(
                    focusNode: confirmPassFocus,
                    enabledBorderColor: Colors.grey,
                    filled: true,
                    hint: LocaleKeys.confirmPassword.tr(),
                    controller: widget.confirmPassController,
                    validate: (value) {
                      if (widget.passController.text !=
                          widget.confirmPassController.text) {
                        return LocaleKeys.passwordDoesNotMatch.tr();
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color:
                          confirmPassFocus.hasFocus
                              ? AppColors.primary
                              : Colors.grey,
                    ),
                    secureText: AuthCubit.get(context).isSecureRegister2,
                    suffixIcon:
                        AuthCubit.get(context).isSecureRegister2
                            ? InkWell(
                              onTap: () {
                                AuthCubit.get(
                                  context,
                                ).isSecureRegisterIcon2(false);
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(8.h),
                                child: Icon(
                                  Icons.visibility_off,
                                  color:
                                      confirmPassFocus.hasFocus
                                          ? AppColors.primary
                                          : Colors.grey,
                                  size: 21.sp,
                                ),
                              ),
                            )
                            : InkWell(
                              onTap: () {
                                AuthCubit.get(
                                  context,
                                ).isSecureRegisterIcon2(true);
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(8.h),
                                child: Icon(
                                  Icons.visibility,
                                  color:
                                      confirmPassFocus.hasFocus
                                          ? AppColors.primary
                                          : Colors.grey,
                                  size: 21.sp,
                                ),
                              ),
                            ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
