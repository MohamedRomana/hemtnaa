import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/alert_dialog.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../on_boarding/on_boarding.dart';
import 'widgets/custom_choose_lang_dialog.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 300.h,
                child: TweenAnimationBuilder(
                  curve: Curves.fastOutSlowIn,
                  tween: Tween<double>(begin: 0, end: 208.w),
                  duration: const Duration(seconds: 1),
                  builder:
                      (context, value, child) => Center(
                        child: Container(
                          height: value.h,
                          width: value.w,
                          margin: EdgeInsets.only(top: 90.w),
                          child: Image.asset(
                            Assets.img.logo.path,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                ),
              ),
              AppText(
                top: 23.h,
                bottom: 22.h,
                text: LocaleKeys.chooseLang.tr(),
                size: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              Center(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    customAlertDialog(
                      context: context,
                      child: const CustomChooseLangDialog(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    width: 311.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xffA2A2A2)),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text:
                              AppCubit.get(context).changeLangIndex == 0
                                  ? LocaleKeys.ar.tr()
                                  : LocaleKeys.en.tr(),
                          size: 16.sp,
                          family: FontFamily.poppinsMedium,
                          color: const Color(0xffA2A2A2),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xffA2A2A2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppButton(
                top: 24.h,
                onPressed: () {
                  if (AppCubit.get(context).changeLangIndex != -1) {
                    if (AppCubit.get(context).changeLangIndex == 0) {
                      CacheHelper.setLang('ar');
                      context.setLocale(const Locale('ar'));
                    } else {
                      CacheHelper.setLang('en');
                      context.setLocale(const Locale('en'));
                    }
                    AppRouter.navigateAndFinish(context, const OnBoarding());
                  } else {
                    showFlashMessage(
                      message: LocaleKeys.chooseLang.tr(),
                      type: FlashMessageType.warning,
                      context: context,
                    );
                  }
                },
                color: AppColors.primary,
                child: AppText(
                  text: LocaleKeys.confirm.tr(),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
