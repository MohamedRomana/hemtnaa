import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import 'widgets/custom_child_score.dart';
import 'widgets/posts_list_view.dart';
import 'widgets/videos_list_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const CustomChildScore(),
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 35.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: TabBar(
                          physics: const BouncingScrollPhysics(),
                          isScrollable: true,
                          splashBorderRadius: BorderRadius.circular(5.r),
                          dividerColor: Colors.transparent,
                          indicatorColor: AppColors.primary,
                          labelColor: AppColors.primary,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: TextStyle(fontSize: 16.sp),
                          tabs: const [
                            Tab(text: 'المنشورات'),
                            Tab(text: 'الفيديوهات'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
          body: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: [PostsListView(), VideosListView()],
          ),
        ),
      ),
    );
  }
}

