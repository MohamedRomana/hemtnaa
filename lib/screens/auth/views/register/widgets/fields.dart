import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/cache/cache_helper.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../data/auth_cubit.dart';

class CustomUserRegisterFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController ageDayController;
  final TextEditingController ageMonthController;
  final TextEditingController ageYearController;
  final TextEditingController childIssueController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;
  final TextEditingController specialityController;

  const CustomUserRegisterFields({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.passController,
    required this.confirmPassController,
    required this.fullNameController,
    required this.emailController,
    required this.childIssueController,
    required this.ageDayController,
    required this.ageMonthController,
    required this.ageYearController,
    required this.specialityController,
  });

  @override
  State<CustomUserRegisterFields> createState() =>
      _CustomUserRegisterFieldsState();
}

class _CustomUserRegisterFieldsState extends State<CustomUserRegisterFields> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode ageFocus = FocusNode();
  final FocusNode childIssueFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode confirmPassFocus = FocusNode();
  final FocusNode specialityFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    nameFocus.addListener(() => setState(() {}));
    phoneFocus.addListener(() => setState(() {}));
    emailFocus.addListener(() => setState(() {}));
    ageFocus.addListener(() => setState(() {}));
    childIssueFocus.addListener(() => setState(() {}));
    passFocus.addListener(() => setState(() {}));
    confirmPassFocus.addListener(() => setState(() {}));
    specialityFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    ageFocus.dispose();
    childIssueFocus.dispose();
    passFocus.dispose();
    confirmPassFocus.dispose();
    specialityFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> days = List.generate(30, (index) => (index + 1).toString());
    List<String> months = List.generate(12, (index) => (index + 1).toString());
    List<String> years = List.generate(
      31,
      (index) => (2000 + index).toString(),
    );
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        List childrenIssue = [
          {'title': 'توحد', 'id': 0},
          {'title': 'ضعف سمع', 'id': 1},
          {'title': 'ضعف بصر', 'id': 2},
        ];
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              AppText(
                text: LocaleKeys.fullName.tr(),
                size: 18.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
                start: 18.w,
              ),
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
              AppText(
                text: LocaleKeys.phone.tr(),
                size: 18.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
                start: 18.w,
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
              AppText(
                text: LocaleKeys.email.tr(),
                size: 18.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
                start: 18.w,
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

              CacheHelper.getUserType() == 'child'
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'تاريخ ميلاد الطفل',
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 8.h,
                        start: 18.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 110.w,
                            child: AppInput(
                              enabledBorderColor: Colors.grey,
                              focusNode: ageFocus,
                              bottom: 18.h,
                              start: 0,
                              end: 0,
                              filled: true,
                              hint: 'اليوم',
                              contentRight: 16.w,
                              controller: widget.ageDayController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'اليوم مطلوب';
                                } else {
                                  return null;
                                }
                              },

                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                                size: 25.sp,
                              ),
                              read: true,
                              onTap: () async {
                                showMenu(
                                  color: Colors.white,
                                  shadowColor: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  context: context,
                                  position: const RelativeRect.fromLTRB(
                                    100,
                                    550,
                                    0,
                                    0,
                                  ),
                                  items: [
                                    PopupMenuItem(
                                      child: Container(
                                        width: 50.w,
                                        height: 200.h,
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            AppText(text: 'اليوم', bottom: 5.h),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: days.length,
                                                itemBuilder:
                                                    (context, index) => InkWell(
                                                      onTap: () {
                                                        widget
                                                            .ageDayController
                                                            .text = days[index];
                                                        Navigator.pop(context);
                                                      },
                                                      child: AppText(
                                                        text: days[index],
                                                        bottom: 3.h,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 110.w,
                            child: AppInput(
                              start: 0,
                              end: 0,

                              enabledBorderColor: Colors.grey,
                              focusNode: ageFocus,
                              bottom: 18.h,
                              filled: true,
                              hint: 'الشهر',
                              controller: widget.ageMonthController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'الشهر مطلوب';
                                } else {
                                  return null;
                                }
                              },

                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                                size: 25.sp,
                              ),
                              read: true,
                              onTap: () async {
                                showMenu(
                                  color: Colors.white,
                                  shadowColor: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  context: context,
                                  position: const RelativeRect.fromLTRB(
                                    200,
                                    550,
                                    120,
                                    0,
                                  ),
                                  items: [
                                    PopupMenuItem(
                                      child: Container(
                                        width: 50.w,
                                        height: 200.h,
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            AppText(text: 'الشهر', bottom: 5.h),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: months.length,
                                                itemBuilder:
                                                    (context, index) => InkWell(
                                                      onTap: () {
                                                        widget
                                                            .ageMonthController
                                                            .text = months[index];
                                                        Navigator.pop(context);
                                                      },
                                                      child: AppText(
                                                        text: months[index],
                                                        bottom: 3.h,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          SizedBox(
                            width: 110.w,
                            child: AppInput(
                              start: 0,
                              end: 0,
                              enabledBorderColor: Colors.grey,
                              focusNode: ageFocus,
                              bottom: 18.h,
                              filled: true,
                              hint: 'السنه',
                              controller: widget.ageYearController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'السنه مطلوب';
                                } else {
                                  return null;
                                }
                              },

                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                                size: 25.sp,
                              ),
                              read: true,
                              onTap: () async {
                                showMenu(
                                  color: Colors.white,
                                  shadowColor: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  context: context,
                                  position: const RelativeRect.fromLTRB(
                                    200,
                                    550,
                                    120,
                                    0,
                                  ),
                                  items: [
                                    PopupMenuItem(
                                      child: Container(
                                        width: 50.w,
                                        height: 200.h,
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            AppText(text: 'السنه', bottom: 5.h),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: years.length,
                                                itemBuilder:
                                                    (context, index) => InkWell(
                                                      onTap: () {
                                                        widget
                                                            .ageYearController
                                                            .text = years[index];
                                                        Navigator.pop(context);
                                                      },
                                                      child: AppText(
                                                        text: years[index],
                                                        bottom: 3.h,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      AppText(
                        text: LocaleKeys.child_issue.tr(),
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 8.h,
                        start: 18.w,
                      ),
                      AppInput(
                        enabledBorderColor: Colors.grey,
                        focusNode: childIssueFocus,
                        bottom: 18.h,
                        filled: true,
                        hint: LocaleKeys.child_issue.tr(),
                        controller: widget.childIssueController,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                          size: 25.sp,
                        ),
                        read: true,
                        onTap: () async {
                          String? value = await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                backgroundColor: AppColors.borderColor,
                                title: AppText(
                                  text: LocaleKeys.child_issue.tr(),
                                  size: 21.sp,
                                ),
                                children:
                                    childrenIssue.map((value) {
                                      return SimpleDialogOption(
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                            value['title'],
                                          );
                                        },
                                        child: AppText(
                                          text: value['title'],
                                          size: 18.sp,
                                          color: AppColors.primary,
                                        ),
                                      );
                                    }).toList(),
                              );
                            },
                          );
                          if (value != null) {
                            widget.childIssueController.text = value;
                          }
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.child_issue_required.tr();
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: Icon(
                          Icons.accessibility_new_outlined,
                          color:
                              childIssueFocus.hasFocus
                                  ? AppColors.primary
                                  : Colors.grey,
                        ),
                      ),
                    ],
                  )
                  : const SizedBox.shrink(),
              AppText(
                text: 'تخصص الدكتور',
                size: 18.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
                start: 18.w,
              ),
              AppInput(
                enabledBorderColor: Colors.grey,
                focusNode: specialityFocus,
                bottom: 18.h,
                filled: true,
                hint: 'تخصص الدكتور',
                controller: widget.specialityController,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'ادخل تخصص الدكتور';
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(
                  Icons.local_hospital_outlined,
                  color:
                      specialityFocus.hasFocus
                          ? AppColors.primary
                          : Colors.grey,
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
              AppText(
                text: LocaleKeys.confirmPassword.tr(),
                size: 18.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
                start: 18.w,
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
