import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_cached.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/widgets/login_first.dart';
import '../../../child_screens/home_layout/home/widgets/posts_list_shimmer.dart';
import 'widgets/add_activity.dart';
import 'widgets/custom_child_rate.dart';

final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _statusController = TextEditingController();
final _startDateController = TextEditingController();
final _endDateController = TextEditingController();
final _descriptionController = TextEditingController();
final _childNameController = TextEditingController();

final class DocRates extends StatefulWidget {
  const DocRates({super.key});

  @override
  State<DocRates> createState() => _DocRatesState();
}

class _DocRatesState extends State<DocRates> {
  @override
  void initState() {
    AppCubit.get(context).getActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton:
              CacheHelper.getUserToken() == ""
                  ? const SizedBox()
                  : FloatingActionButton(
                    onPressed: () {
                      AppRouter.navigateTo(
                        context,
                        AddActivity(
                          nameController: _nameController,
                          statusController: _statusController,
                          endDateController: _endDateController,
                          startDateController: _startDateController,
                          descriptionController: _descriptionController,
                          formKey: _formKey,
                          childNameController: _childNameController,
                        ),
                      );
                    },
                    mini: true,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.add, size: 24.sp, color: Colors.white),
                  ),
          body:
              CacheHelper.getUserToken() == ""
                  ? const LoginFirst()
                  : state is GetActivitiesLoading
                  ? const PostsListShimmer()
                  : ListView.separated(
                    padding: EdgeInsets.only(top: 60.h, bottom: 30.h),
                    physics: const BouncingScrollPhysics(),
                    itemCount: AppCubit.get(context).getActivitiesList.length,
                    separatorBuilder:
                        (context, index) => SizedBox(height: 16.h),
                    itemBuilder:
                        (context, index) => Container(
                          width: 343.w,
                          padding: EdgeInsets.all(16.r),
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.2),
                                spreadRadius: 1.r,
                                blurRadius: 5.r,
                                offset: Offset(0, 5.r),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  AppCubit.get(
                                            context,
                                          ).getActivitiesList[index]['activity_image'] ==
                                          null
                                      ? Container(
                                        height: 60.w,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            150.r,
                                          ),
                                          border: Border.all(
                                            color: AppColors.primary,
                                            width: 2.w,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary
                                                  .withAlpha(100),
                                              blurRadius: 5.r,
                                              spreadRadius: 1.r,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                      )
                                      : ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          1000.r,
                                        ),
                                        child: AppCachedImage(
                                          image:
                                              AppCubit.get(
                                                context,
                                              ).getActivitiesList[index]['activity_image'] ??
                                              "",
                                          height: 50.w,
                                          width: 50.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: AppText(
                                          text:
                                              AppCubit.get(
                                                context,
                                              ).getActivitiesList[index]['child_name'] ??
                                              "",
                                          size: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          start: 8.w,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 150.w,
                                        child: AppText(
                                          text:
                                              AppCubit.get(
                                                context,
                                              ).getActivitiesList[index]['activity_name'] ??
                                              "",
                                          size: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          start: 8.w,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 150.w,
                                        child: AppText(
                                          text:
                                              AppCubit.get(
                                                context,
                                              ).getActivitiesList[index]['details'] ??
                                              "",
                                          size: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          start: 8.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const CustomChildRate(),
                            ],
                          ),
                        ),
                  ),
        );
      },
    );
  }
}
