// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/gen/assets.gen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_cached.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../generated/locale_keys.g.dart';
import '../drawer/drawer.dart';
import 'widgets/edit_profile_fields.dart';

final _firstNameController = TextEditingController();
final _lastNameController = TextEditingController();
final _emailController = TextEditingController();

String profileEditPhoneCode = "+20";

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          resizeToAvoidBottomInset: true,
          skey: scaffoldKey,
          drawer: const CustomDrawer(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.h),
            child: CustomAppBar(
              scaffoldKey: scaffoldKey,
              title: 'تعديل الملف الشخصي',
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                AppCubit.get(context).profileImage.isEmpty
                    ? InkWell(
                      onTap:
                          () => AppCubit.get(context).getProfileImage(context),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Stack(
                        children: [
                          AppCubit.get(context).userMap["profile_picture"] ==
                                  null
                              ? Container(
                                width: 120.w,
                                height: 120.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(100.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.2),
                                      spreadRadius: 1.r,
                                      blurRadius: 5.r,
                                      offset: Offset(0, 5.r),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: Image.asset(
                                    Assets.img.logo.path,
                                    width: 120.w,
                                    height: 120.w,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: AppCachedImage(
                                  image:
                                      AppCubit.get(
                                        context,
                                      ).userMap["profile_picture"],
                                  width: 120.w,
                                  height: 120.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          PositionedDirectional(
                            end: 0,
                            child: Icon(
                              Icons.edit_square,
                              color: AppColors.primary,
                              size: 25.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                    : Stack(
                      children: [
                        Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(
                                AppCubit.get(context).profileImage.first,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          child: InkWell(
                            onTap:
                                () =>
                                    AppCubit.get(context).removeProfileImage(),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                SizedBox(height: 20.h),
                EditProfileFields(
                  emailController: _emailController,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                ),
                BlocConsumer<AppCubit, AppState>(
                  listener: (context, state) {
                    if (state is UpdateUserSuccess) {
                      AppRouter.pop(context);
                      showFlashMessage(
                        message: state.message,
                        type: FlashMessageType.success,
                        context: context,
                      );
                      _firstNameController.clear();
                      _lastNameController.clear();
                      _emailController.clear();
                    } else if (state is UpdateUserFailure) {
                      showFlashMessage(
                        message: state.error,
                        type: FlashMessageType.error,
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      elevation: WidgetStatePropertyAll(3.r),
                      shadowColor: const WidgetStatePropertyAll(
                        AppColors.primary,
                      ),
                      top: 24.h,
                      width: 311.w,
                      onPressed: () {
                        AppCubit.get(context).updateUser(
                          firstName:
                              _firstNameController.text.isEmpty
                                  ? AppCubit.get(context).userMap["first_name"]
                                  : _firstNameController.text,
                          lastName:
                              _lastNameController.text.isEmpty
                                  ? AppCubit.get(context).userMap["last_name"]
                                  : _lastNameController.text,
                          email:
                              _emailController.text.isEmpty
                                  ? AppCubit.get(context).userMap["email"]
                                  : _emailController.text,
                          profileId:
                              AppCubit.get(context).userMap["id"].toString(),
                        );
                      },
                      child:
                          state is UploadImagesLoading ||
                                  state is UpdateUserLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : AppText(
                                text: LocaleKeys.save.tr(),
                                size: 21.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                    );
                  },
                ),

                SizedBox(height: 150.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
