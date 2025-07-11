import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/cache/cache_helper.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_cached.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import 'package:hemtnaa/core/widgets/login_first.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/alert_dialog.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../core/widgets/logout_dialog.dart';
import '../../../../gen/assets.gen.dart';
import '../../../auth/data/auth_cubit.dart';
import '../../../auth/views/login/login.dart';
import '../../../child_screens/drawer/drawer.dart';
import '../../doc_profile/profile.dart';
import 'widgets/publish_post_sheet.dart';
import 'widgets/doc_posts_list.dart';

class DocHome extends StatefulWidget {
  const DocHome({super.key});

  @override
  State<DocHome> createState() => _DocHomeState();
}

class _DocHomeState extends State<DocHome> {
  @override
  void initState() {
    AppCubit.get(context).showUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: const CustomDrawer(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.h),
            child: Container(
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
                      text: 'الرئيسية',
                      size: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LogOutLoading) {
                          showLoadingDialog(context: context, isLottie: true);
                        } else if (state is LogOutSuccess) {
                          showFlashMessage(
                            context: context,
                            type: FlashMessageType.success,
                            message: state.message,
                          );
                          AppRouter.navigateAndFinish(context, const LogIn());
                        } else if (state is LogOutFailure) {
                          AppRouter.pop(context);
                          showFlashMessage(
                            context: context,
                            type: FlashMessageType.error,
                            message: state.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            customAlertDialog(
                              context: context,
                              dialogBackGroundColor: AppColors.borderColor,
                              child: const LogoutDialog(),
                            );
                          },
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          body:
              CacheHelper.getUserToken() == ""
                  ? const LoginFirst()
                  : SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 16.w),
                            InkWell(
                              onTap: () {
                                AppRouter.navigateTo(
                                  context,
                                  const DocProfile(),
                                );
                              },
                              child:
                                  AppCubit.get(
                                            context,
                                          ).userMap["profile_picture"] ==
                                          null
                                      ? Container(
                                        height: 48.w,
                                        width: 48.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary
                                                  .withOpacity(0.2),
                                              spreadRadius: 1.r,
                                              blurRadius: 5.r,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            Assets.img.logo.path,
                                            height: 48.w,
                                            width: 48.w,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                      : ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        child: AppCachedImage(
                                          image:
                                              AppCubit.get(
                                                context,
                                              ).userMap["profile_picture"] ??
                                              "",
                                          width: 48.w,
                                          height: 48.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                            ),
                            SizedBox(width: 8.w),
                            SizedBox(
                              width: 300.w,
                              child: AppInput(
                                start: 0,
                                end: 16.w,
                                hint: 'بماذا تفكر؟ ',
                                read: true,
                                enabledBorderColor: AppColors.borderColor,
                                focusedBorderColor: AppColors.borderColor,
                                color: AppColors.borderColor,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.white,
                                    builder: (_) => const PublishPostSheet(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        const DocPostsList(),
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
