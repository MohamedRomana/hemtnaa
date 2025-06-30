import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/login_first.dart';
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
  initState() {
    AppCubit.get(context).showUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: const CustomDrawer(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.h),
            child: CustomAppBar(scaffoldKey: scaffoldKey, title: 'الرئيسيه'),
          ),
          body:
              CacheHelper.getUserToken() == ""
                  ? const LoginFirst()
                  : const SingleChildScrollView(
                    child: Column(
                      children: [CustomChildScore(), PostsListView()],
                    ),
                  ),
        );
      },
    );
  }
}
