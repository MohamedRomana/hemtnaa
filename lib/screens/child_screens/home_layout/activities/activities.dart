import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_button.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';

import '../../../../core/widgets/custom_app_bar.dart';
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
                  bottom: 120.h,
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
                      child: Row(
                        children: [
                          Container(
                            height: 16.w,
                            clipBehavior: Clip.antiAlias,

                            width: 16.w,
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
                              height: 16.w,
                              width: 16.w,
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
                                  size: 10.sp,
                                ),
                              ),
                            ),
                          ),
                          AppText(
                            text: 'اكل الطفل الطعام كامل',
                            size: 14.sp,
                            color:
                                AppCubit.get(
                                      context,
                                    ).selectedIndexes.contains(index)
                                    ? AppColors.primary
                                    : Colors.black,
                            start: 8.w,
                          ),
                        ],
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
