import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/cache/cache_helper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../child_screens/home_layout/home_layout.dart';
import '../../../doctor_screens/home_layout/doc_home_layout.dart';
import '../../data/auth_cubit.dart';
import '../forget_pass/forget_pass.dart';
import '../register/register.dart';
import '../widgets/auth_header.dart';
import 'widgets/login_fields.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  void initState() {
    _emailController.clear();
    _passController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const CustomAuthHeader(),
            CustomLoginFields(
              formKey: _formKey,
              emailController: _emailController,
              passController: _passController,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LogInSuccess) {
                  // AppCubit.get(context).changebottomNavIndex(1);
                  // AppRouter.navigateAndFinish(context, const HomeLayout());
                  _emailController.clear();
                  _passController.clear();
                  showFlashMessage(
                    context: context,
                    type: FlashMessageType.success,
                    message: LocaleKeys.welcome_dear_customer.tr(),
                  );
                } else if (state is LogInFailure) {
                  showFlashMessage(
                    context: context,
                    type: FlashMessageType.error,
                    message: "error",
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  top: 24.h,
                  bottom: 16.h,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await AuthCubit.get(context).logIn(
                        email: _emailController.text,
                        password: _passController.text,
                      );
                    }
                  },
                  child:
                      state is LogInLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : AppText(
                            text: LocaleKeys.signin.tr(),
                            color: Colors.white,
                            family: FontFamily.poppinsBold,
                          ),
                );
              },
            ),
            AppButton(
              onPressed: () {
                if (CacheHelper.getUserType() == 'Child') {
                  AppCubit.get(context).changebottomNavIndex(0);
                  AppRouter.navigateAndFinish(context, const HomeLayout());
                } else if (CacheHelper.getUserType() == 'Doctor') {
                  AppCubit.get(context).changebottomDocNavIndex(0);
                  AppRouter.navigateAndFinish(context, const DocHomeLayout());
                }
              },
              child: AppText(
                textAlign: TextAlign.center,
                text: LocaleKeys.home.tr(),
                size: 14.sp,
                color: Colors.white,
                family: FontFamily.poppinsBold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: LocaleKeys.dontHaveAccount.tr(),
                  size: 14.sp,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, const Register());
                  },
                  child: AppText(
                    text: LocaleKeys.newUser.tr(),
                    size: 14.sp,
                    color: AppColors.third,
                    family: FontFamily.poppinsMedium,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed:
                  () => AppRouter.navigateTo(context, const ForgetPass()),
              child: AppText(
                text: LocaleKeys.forgetPass.tr(),
                size: 14.sp,
                color: AppColors.secondray,
                family: FontFamily.poppinsMedium,
              ),
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }
}
