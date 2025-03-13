import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomChooseLangDialog extends StatefulWidget {
  const CustomChooseLangDialog({super.key});

  @override
  State<CustomChooseLangDialog> createState() => _CustomChooseLangDialogState();
}

class _CustomChooseLangDialogState extends State<CustomChooseLangDialog> {
  @override
  void initState() {
    AppCubit.get(context).changeLangIndexs(index: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              bottom: 20.h,
              text: LocaleKeys.chooseLang.tr(),
              size: 20.sp,
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changeLangIndexs(index: 0);
              },
              child: Row(
                children: [
                  Container(
                    height: 25.w,
                    width: 25.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            AppCubit.get(context).changeLangIndex == 0
                                ? AppColors.primary
                                : Colors.grey,
                        width: 2.w,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      height: 25.w,
                      width: 25.w,
                      margin: EdgeInsetsDirectional.all(3.r),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).changeLangIndex == 0
                                ? AppColors.primary
                                : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  AppText(
                    start: 20.w,
                    text: LocaleKeys.ar.tr(),
                    size: 20.sp,
                    color: Colors.black,
                    family: FontFamily.poppinsMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changeLangIndexs(index: 1);
              },
              child: Row(
                children: [
                  Container(
                    height: 25.w,
                    width: 25.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            AppCubit.get(context).changeLangIndex == 1
                                ? AppColors.primary
                                : Colors.grey,
                        width: 2.w,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      height: 25.w,
                      width: 25.w,
                      margin: EdgeInsetsDirectional.all(3.r),
                      decoration: BoxDecoration(
                        color:
                            AppCubit.get(context).changeLangIndex == 1
                                ? AppColors.primary
                                : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  AppText(
                    start: 20.w,
                    text: LocaleKeys.en.tr(),
                    size: 20.sp,
                    color: Colors.black,
                    family: FontFamily.poppinsMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            Divider(color: Colors.grey, thickness: 1.w),
            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    AppCubit.get(context).changeLangIndexs(index: 0);
                    Navigator.pop(context);
                  },
                  child: AppText(text: LocaleKeys.cancel.tr(), size: 16.sp),
                ),

                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: AppText(
                    start: 15.w,
                    text: LocaleKeys.agree.tr(),
                    size: 16.sp,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
