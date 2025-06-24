import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_button.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../gen/assets.gen.dart';
import '../../drawer/drawer.dart';

class Activities extends StatelessWidget {
  const Activities({super.key});

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
            child: CustomAppBar(scaffoldKey: scaffoldKey, title: 'الانشطه'),
          ),

          body: Stack(
            children: [
              ListView.separated(
                padding: EdgeInsetsDirectional.only(
                  start: 24.w,
                  end: 24.w,
                  bottom: 180.h,
                  top: 16.h
                ),
                itemCount: 10,
                separatorBuilder: (context, index) => SizedBox(height: 18.h),
                itemBuilder:
                    (context, index) => InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changeActiveIndexs(index: index);
                      },
                      child: Container(
                        width: 343.w,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.2),
                              spreadRadius: 1.r,
                              blurRadius: 5.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 55.w,
                              width: 55.w,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(1000.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.5),
                                    spreadRadius: 1.r,
                                    blurRadius: 5.r,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000.r),
                                child: Image.asset(
                                  Assets.img.tree.path,
                                  height: 55.w,
                                  width: 55.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  child: AppText(
                                    text: 'اكل الطفل الطعام كامل',
                                    size: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        AppCubit.get(
                                              context,
                                            ).selectedIndexes.contains(index)
                                            ? AppColors.primary
                                            : Colors.black,
                                    start: 8.w,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 8.w,
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'الوقت المتبقي للانتهاء : ',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.darkRed,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '2 ساعات',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 200.w,
                                //   child: AppText(
                                //     text: 'الوقت المتبقي للانتهاء : 2 ساعات',
                                //     size: 14.sp,
                                //     fontWeight: FontWeight.w500,
                                //     color: Colors.black,
                                //     start: 8.w,
                                //   ),
                                // ),
                                SizedBox(
                                  width: 200.w,
                                  child: AppText(
                                    text:
                                        'شرح هذا النشاط هو ان يقوم الطفل بالاكل الطعام كامل',
                                    size: 12.sp,
                                    lines: 3,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    start: 8.w,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              height: 20.w,
                              clipBehavior: Clip.antiAlias,
                              width: 20.w,
                              decoration: BoxDecoration(
                                color: const Color(0xffEDEDED),
                                border: Border.all(
                                  color:
                                      AppCubit.get(
                                            context,
                                          ).selectedIndexes.contains(index)
                                          ? Colors.transparent
                                          : Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                height: 20.w,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color:
                                      AppCubit.get(
                                            context,
                                          ).selectedIndexes.contains(index)
                                          ? const Color(0xff2563EB)
                                          : Colors.transparent,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    color:
                                        AppCubit.get(
                                              context,
                                            ).selectedIndexes.contains(index)
                                            ? Colors.white
                                            : Colors.transparent,
                                    size: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
              PositionedDirectional(
                bottom: 120.h,
                end: 24.w,
                child: SizedBox(
                  height: 44.h,
                  child: AppButton(
                    onPressed: () {},
                    width: 68.w,
                    radius: 8.r,
                    child: AppText(
                      text: 'حفظ',
                      size: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
