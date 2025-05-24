import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../drawer/drawer.dart';
import 'widgets/chats_list_view.dart';
import 'widgets/groubs_list_view.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: CustomAppBar(scaffoldKey: scaffoldKey, title: 'المحادثات'),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        width: 343.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.borderColor.withAlpha(100),
                        ),
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicatorColor: AppColors.primary,
                          labelColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          unselectedLabelColor: Colors.grey,
                          labelStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
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
            children: [ChatsListView(), GroubsListView()],
          ),
        ),
      ),
    );
  }
}
