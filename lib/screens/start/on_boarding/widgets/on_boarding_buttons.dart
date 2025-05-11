// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../types/types_view.dart';

class CustomOnBoardingButtons extends StatelessWidget {
  const CustomOnBoardingButtons({
    super.key,
    required this.pagesList,
    required this.currPage,
    required this.pageController,
  });

  final List pagesList;
  final double currPage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 48.h,
      child: Column(
        children: [
          SizedBox(height: 35.h),
          Row(
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 125.w,
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(25.r),
                        bottomEnd: Radius.circular(25.r),
                      ),
                    ),
                    child:
                        currPage <= pagesList.length - 1.5
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                AppText(
                                  text: LocaleKeys.next.tr(),
                                  color: Colors.white,
                                  size: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            )
                            : InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                if (currPage == pagesList.length - 1) {
                                  CacheHelper.setLang('ar');
                                  context.setLocale(const Locale('ar'));
                                  AppRouter.navigateAndPop(
                                    context,
                                    const TypesView(),
                                  );
                                } else {
                                  pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width:
                                        CacheHelper.getLang() == 'ar'
                                            ? 56.w
                                            : 60.w,
                                    child: AppText(
                                      text: LocaleKeys.start_now.tr(),
                                      color: Colors.white,
                                      size:
                                          CacheHelper.getLang() == 'ar'
                                              ? 16.sp
                                              : 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  ),
                ),
              ),
              SizedBox(width: 150.w),
              Visibility(
                visible: currPage <= pagesList.length - 1.5,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        pageController.animateToPage(
                          pagesList.length - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: AppText(
                        text: LocaleKeys.skip.tr(),
                        color: Colors.black,
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
