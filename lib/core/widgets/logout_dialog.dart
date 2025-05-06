import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_lottie_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../gen/fonts.gen.dart';
import '../../screens/start/types/types_view.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          top: 20.h,
          text: LocaleKeys.logout.tr(),
          size: 18.sp,
          family: FontFamily.lexendBold,
          color: AppColors.primary,
          bottom: 18.h,
        ),
        AppText(
          text: LocaleKeys.logOutSubtitle.tr(),
          family: FontFamily.lexendBold,
          color: AppColors.primary,
        ),
        CustomLottieWidget(
          lottieName: Assets.img.alert,
          height: 90.w,
          width: 90.w,
          top: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                AppRouter.pop(context);
                AppRouter.navigateTo(context, const TypesView());
                // AuthCubit.get(context).logOut();
              },
              child: AppText(
                text: LocaleKeys.yes.tr(),
                color: Colors.red,
                family: FontFamily.lexendBold,
              ),
            ),
            TextButton(
              onPressed: () {
                AppRouter.pop(context);
              },
              child: AppText(
                text: LocaleKeys.no.tr(),
                color: AppColors.primary,
                family: FontFamily.lexendBold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
