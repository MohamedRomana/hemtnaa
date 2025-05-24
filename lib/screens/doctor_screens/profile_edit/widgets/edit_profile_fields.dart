// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class EditProfileFields extends StatefulWidget {
  final TextEditingController passController;
  final TextEditingController firstNameController;
  final TextEditingController phoneController;
  const EditProfileFields({
    super.key,
    required this.passController,
    required this.phoneController,
    required this.firstNameController,
  });

  @override
  State<EditProfileFields> createState() => _EditProfileFieldsState();
}

class _EditProfileFieldsState extends State<EditProfileFields> {
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode passFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    phoneFocusNode.addListener(() => setState(() {}));
    nameFocusNode.addListener(() => setState(() {}));
    passFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    nameFocusNode.dispose();
    passFocusNode.dispose();
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
              fontWeight: FontWeight.w500,
            ),
            Container(
              width: 343.w,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.sp),
              margin: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    spreadRadius: 1.r,
                    blurRadius: 5.r,
                    offset: Offset(0, 5.r), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  AppInput(
                    filled: true,
                    enabledBorderColor: Colors.grey,
                    hint: "اسم المستخدم",
                    focusNode: nameFocusNode,
                    controller: widget.firstNameController,
                    focusedBorderColor: AppColors.primary,
                    prefixIcon: SizedBox(
                      height: 25.w,
                      width: 25.w,
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  AppInput(
                    filled: true,
                    enabledBorderColor: Colors.grey,
                    hint: "01000000000",
                    focusNode: phoneFocusNode,
                    focusedBorderColor: AppColors.primary,
                    controller: widget.phoneController,
                    inputType: TextInputType.phone,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: SvgPicture.asset(
                        Assets.svg.phone,
                        height: 25.w,
                        width: 25.w,
                        color:
                            phoneFocusNode.hasFocus
                                ? AppColors.primary
                                : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      return AppInput(
                        filled: true,
                        focusNode: passFocusNode,
                        focusedBorderColor: AppColors.primary,
                        hint: LocaleKeys.password.tr(),
                        enabledBorderColor: Colors.grey,
                        controller: widget.passController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.passwordValidate.tr();
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: Icon(
                          Icons.lock,
                          color:
                              passFocusNode.hasFocus
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
                                          passFocusNode.hasFocus
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
