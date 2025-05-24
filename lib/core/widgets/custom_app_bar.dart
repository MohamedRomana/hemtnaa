import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../gen/assets.gen.dart';
import '../../screens/child_screens/profile/profile.dart';
import '../cache/cache_helper.dart';
import '../constants/colors.dart';
import 'app_router.dart';
import 'app_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isHome;
  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.title,
    this.isHome = false,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(15.r),
          bottomStart: Radius.circular(15.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu, color: Colors.white),
            ),
            AppText(
              top: 8.h,
              text: title,
              size: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            const Spacer(),

            // BlocConsumer<AuthCubit, AuthState>(
            //   listener: (context, state) {
            //     if (state is LogOutLoading) {
            //       showLoadingDialog(context: context, isLottie: true);
            //     } else if (state is LogOutSuccess) {
            //       showFlashMessage(
            //         context: context,
            //         type: FlashMessageType.success,
            //         message: state.message,
            //       );
            //       AppRouter.navigateAndFinish(context, const LogIn());
            //     } else if (state is LogOutFailure) {
            //       AppRouter.pop(context);
            //       showFlashMessage(
            //         context: context,
            //         type: FlashMessageType.error,
            //         message: state.error,
            //       );
            //     }
            //   },
            //   builder: (context, state) {
            //     return IconButton(
            //       onPressed: () {
            //         customAlertDialog(
            //           context: context,
            //           dialogBackGroundColor: AppColors.borderColor,
            //           child: const LogoutDialog(),
            //         );
            //       },
            //       icon: const Icon(Icons.logout_outlined, color: Colors.white),
            //     );
            //   },
            // ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppRouter.navigateTo(context, const Profile());
              },
              child: Icon(
                Icons.help_outline_rounded,
                size: 24.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 7.w),
            if (isHome)
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppRouter.pop(context);
                },
                child:
                    CacheHelper.getLang() == "en"
                        ? Transform.scale(
                          scaleX: -1,
                          child: SvgPicture.asset(
                            Assets.svg.arrowleftcircle,
                            color: Colors.white,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                        )
                        : SvgPicture.asset(
                          Assets.svg.arrowleftcircle,
                          color: Colors.white,
                          height: 24.w,
                          width: 24.w,
                          fit: BoxFit.cover,
                        ),
              ),
          ],
        ),
      ),
    );
  }
}
