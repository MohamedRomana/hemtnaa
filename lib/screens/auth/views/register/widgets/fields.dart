import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
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
import '../register.dart';

class CustomUserRegisterFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController ageDayController;
  final TextEditingController childIssueController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;
  final TextEditingController specialityController;
  final TextEditingController levelController;

  const CustomUserRegisterFields({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.passController,
    required this.confirmPassController,
    required this.emailController,
    required this.childIssueController,
    required this.ageDayController,
    required this.specialityController,
    required this.firstNameController,
    required this.lastNameController,
    required this.levelController,
  });

  @override
  State<CustomUserRegisterFields> createState() =>
      _CustomUserRegisterFieldsState();
}

class _CustomUserRegisterFieldsState extends State<CustomUserRegisterFields> {
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
        List childrenIssue = [
          {'title': 'توحد', 'id': 0},
          {'title': 'ضعف سمع', 'id': 1},
          {'title': 'ضعف بصر', 'id': 2},
        ];
        List level = [
          {'title': 'حضانه', 'id': 0},
          {'title': 'ابتدائي', 'id': 1},
          {'title': 'اعدادي', 'id': 2},
        ];
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              AppText(
                text: LocaleKeys.firstName.tr(),
                size: 18.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
                start: 18.w,
              ),
              AppInput(
                enabledBorderColor: Colors.grey,
                focusNode: firstnameFocus,
                bottom: 18.h,
                filled: true,
                hint: LocaleKeys.firstName.tr(),
                controller: widget.firstNameController,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.firstNameValidate.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(
                  Icons.person_outline,
                  color:
                      firstnameFocus.hasFocus ? AppColors.primary : Colors.grey,
                  size: 30.sp,
                ),
              ),
              AppText(
                text: LocaleKeys.lastName.tr(),
                size: 18.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
                start: 18.w,
              ),
              AppInput(
                enabledBorderColor: Colors.grey,
                focusNode: lastnameFocus,
                bottom: 18.h,
                filled: true,
                hint: LocaleKeys.lastName.tr(),
                controller: widget.lastNameController,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.lastNameValidate.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(
                  Icons.person_outline,
                  color:
                      lastnameFocus.hasFocus ? AppColors.primary : Colors.grey,
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
                              userRegisterPhoneCode = country.phoneCode;
                              debugPrint(userRegisterPhoneCode);
                            },
                          ),
                        ),
                        Container(
                          height: 24.h,
                          width: 1.w,
                          decoration: const BoxDecoration(color: Colors.grey),
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

              CacheHelper.getUserType() == 'Child'
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
                      AppInput(
                        enabledBorderColor: Colors.grey,
                        prefixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color:
                              ageFocus.hasFocus
                                  ? AppColors.primary
                                  : Colors.grey,
                        ),
                        focusNode: ageFocus,
                        bottom: 18.h,
                        filled: true,
                        hint: 'تاريخ ميلاد الطفل',
                        contentRight: 16.w,
                        controller: widget.ageDayController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'تاريخ ميلاد الطفل مطلوب';
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
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                            builder:
                                (context, child) => Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: AppColors.primary,
                                      onPrimary: Colors.white,
                                      surface: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                  ),
                                  child: child!,
                                ),
                          );
                          if (dateTime != null) {
                            String formattedDate = DateFormat(
                              'yyyy-MM-dd',
                            ).format(dateTime);
                            setState(() {
                              widget.ageDayController.text = formattedDate;
                            });
                          }
                        },
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
                                          fontWeight: FontWeight.bold,
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
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),
              AppText(
                text: 'المستوى التعليمي',
                size: 18.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
                start: 18.w,
              ),
              AppInput(
                enabledBorderColor: Colors.grey,
                focusNode: levelFocus,
                bottom: 18.h,
                filled: true,
                hint: 'المستوى التعليمي',
                controller: widget.levelController,
                read: true,
                onTap: () async {
                  String? value = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        backgroundColor: AppColors.borderColor,
                        title: AppText(text: 'المستوى التعليمي', size: 21.sp),
                        children:
                            level.map((value) {
                              return SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, value['title']);
                                },
                                child: AppText(
                                  text: value['title'],
                                  size: 18.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList(),
                      );
                    },
                  );
                  if (value != null) {
                    widget.levelController.text = value;
                  }
                },
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: 25.sp,
                ),
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'ادخل المستوى التعليمي';
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(
                  Icons.school_outlined,
                  color: levelFocus.hasFocus ? AppColors.primary : Colors.grey,
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
