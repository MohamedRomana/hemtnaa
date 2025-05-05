import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../data/auth_cubit.dart';

class CustomLoginFields extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passController;
  final GlobalKey<FormState> formKey;

  const CustomLoginFields({
    super.key,
    required this.emailController,
    required this.passController,
    required this.formKey,
  });

  @override
  State<CustomLoginFields> createState() => _CustomLoginFieldsState();
}

class _CustomLoginFieldsState extends State<CustomLoginFields> {
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    emailFocus.addListener(() => setState(() {}));
    passFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100.h),

          AppText(
            text: LocaleKeys.email.tr(),
            size: 18.sp,
            fontWeight: FontWeight.bold,
            bottom: 8.h,
            start: 18.w,
          ),
          AppInput(
            bottom: 16.h,
            filled: true,
            focusNode: emailFocus,
            enabledBorderColor: Colors.grey,
            focusedBorderColor: AppColors.primary,
            hint: LocaleKeys.email.tr(),
            color: Colors.white,
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
          AppText(
            text: LocaleKeys.password.tr(),
            size: 18.sp,
            fontWeight: FontWeight.bold,
            bottom: 8.h,
            start: 18.w,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return AppInput(
                focusNode: passFocusNode,
                enabledBorderColor: Colors.grey,
                focusedBorderColor: AppColors.primary,
                filled: true,
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
                  Icons.lock_outlined,
                  color:
                      passFocusNode.hasFocus ? AppColors.primary : Colors.grey,
                ),
                secureText: AuthCubit.get(context).isSecureLogIn,
                suffixIcon:
                    AuthCubit.get(context).isSecureLogIn
                        ? InkWell(
                          onTap: () {
                            AuthCubit.get(context).isSecureLogInIcon(false);
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Icon(
                              Icons.visibility_off,
                              color:
                                  passFocusNode.hasFocus
                                      ? AppColors.primary
                                      : Colors.grey,
                              size: 21.sp,
                            ),
                          ),
                        )
                        : InkWell(
                          onTap: () {
                            AuthCubit.get(context).isSecureLogInIcon(true);
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Icon(
                              Icons.visibility,
                              color:
                                  passFocusNode.hasFocus
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
  }
}
