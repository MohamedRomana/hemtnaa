import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/custom_app_bar.dart';
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
    super.initState();
    AppCubit.get(context).postsView();
  }

  Future<void> _refresh() async {
    AppCubit.get(context).postsView();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {});
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
          body: RefreshIndicator(
            onRefresh: _refresh,
            color: AppColors.primary,
            backgroundColor: Colors.white,
            child: const SingleChildScrollView(
              child: Column(children: [CustomChildScore(), PostsListView()]),
            ),
          ),
        );
      },
    );
  }
}
