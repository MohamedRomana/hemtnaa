import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/alert_dialog.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../core/widgets/logout_dialog.dart';
import '../../../auth/data/auth_cubit.dart';
import '../../../auth/views/login/login.dart';
import '../../drawer/drawer.dart';
import 'widgets/custom_child_score.dart';
import 'widgets/posts_list_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
          body: const SingleChildScrollView(
            child: Column(children: [CustomChildScore(), PostsListView()]),
          ),
        );
      },
    );
  }
}
