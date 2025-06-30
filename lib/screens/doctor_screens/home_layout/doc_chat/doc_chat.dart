import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/login_first.dart';
import 'widgets/doc_chat_list.dart';
import 'widgets/doc_groub_list.dart';

class DocChat extends StatelessWidget {
  const DocChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          CacheHelper.getUserToken() == ""
              ? const LoginFirst()
              : DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (context, innerBoxIsScrolled) => [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                  start: 35.w,
                                  top: 60.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: TabBar(
                                  physics: const BouncingScrollPhysics(),
                                  isScrollable: true,
                                  splashBorderRadius: BorderRadius.circular(
                                    5.r,
                                  ),
                                  dividerColor: Colors.transparent,
                                  indicatorColor: AppColors.primary,
                                  labelColor: AppColors.primary,
                                  unselectedLabelColor: Colors.grey,
                                  labelStyle: TextStyle(fontSize: 16.sp),
                                  tabs: const [
                                    Tab(text: 'المحادثات'),
                                    Tab(text: 'المجموعات'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                  body: const TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [DocChatList(), DocGroubList()],
                  ),
                ),
              ),
    );
  }
}
