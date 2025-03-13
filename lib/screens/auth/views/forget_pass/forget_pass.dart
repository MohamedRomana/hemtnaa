import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/auth_cubit.dart';
import '../reset_pass/reset_pass.dart';
import '../widgets/auth_header.dart';

final _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();
String forgetPassPhoneCode = "";

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final FocusNode emailFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CustomAuthHeader(isresetPass: true),
              SizedBox(height: 50.h),
              Align(
                alignment: Alignment.center,
                child: AppText(
                  top: 26.h,
                  text: LocaleKeys.email.tr(),
                  size: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AppText(
                  top: 14.h,
                  text: LocaleKeys.enterEmailToSendActivationCode.tr(),
                  color: Colors.grey,
                  size: 14.sp,
                ),
              ),
              AppInput(
                focusNode: emailFocusNode,
                top: 27.h,
                bottom: 24.h,
                filled: true,
                enabledBorderColor: Colors.grey,
                hint: LocaleKeys.email.tr(),
                controller: _emailController,
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
                  color:
                      emailFocusNode.hasFocus ? AppColors.primary : Colors.grey,
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ForgetPassFailure) {
                    showFlashMessage(
                      context: context,
                      type: FlashMessageType.error,
                      message: state.error,
                    );
                  } else if (state is ForgetPassSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPass(),
                      ),
                    );
                    _emailController.clear();
                    showFlashMessage(
                      context: context,
                      type: FlashMessageType.success,
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) {
                  return Center(
                    child: AppButton(
                      onPressed: () async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPass(),
                          ),
                        );
                        if (_formKey.currentState!.validate()) {
                          AuthCubit.get(
                            context,
                          ).forgetPass(phone: _emailController.text);
                        }
                      },
                      child:
                          state is ForgetPassLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : AppText(
                                text: LocaleKeys.confirm.tr(),
                                color: Colors.white,
                                family: FontFamily.poppinsBold,
                              ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
