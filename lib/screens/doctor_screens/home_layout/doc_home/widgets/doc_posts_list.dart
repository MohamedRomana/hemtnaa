import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_cached.dart';
import 'package:hemtnaa/core/widgets/custom_lottie_widget.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/login_first.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../child_screens/home_layout/home/widgets/posts_list_shimmer.dart';
import '../../../doc_doctor_view/doctor_view.dart';
import 'doc_posts_views.dart';

class DocPostsList extends StatefulWidget {
  const DocPostsList({super.key});

  @override
  State<DocPostsList> createState() => _DocPostsListState();
}

class _DocPostsListState extends State<DocPostsList> {
  @override
  void initState() {
    AppCubit.get(context).getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return AppCubit.get(context).postsList.isEmpty
            ? Column(
              children: [
                SizedBox(height: 100.h),
                CustomLottieWidget(lottieName: Assets.img.emptyorder),
                AppText(
                  text: "لا يوجد بوستات",
                  size: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ],
            )
            : state is GetPostsLoading
            ? const PostsListShimmer()
            : CacheHelper.getUserToken() == ""
            ? const LoginFirst()
            : ListView.separated(
              padding: EdgeInsetsDirectional.only(
                start: 24.w,
                end: 24.w,
                bottom: 120.h,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppCubit.get(context).postsList.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final timestamp =
                    AppCubit.get(context).postsList[index]['timestamp'];
                final dateTime = DateTime.parse(timestamp);
                final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                return Container(
                  width: 343.w,
                  padding: EdgeInsetsDirectional.only(
                    start: 12.w,
                    top: 12.h,
                    bottom: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color:
                        index.isEven
                            ? const Color(0xffFFF5DF)
                            : const Color(0xffDFEBFF),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        spreadRadius: 1.r,
                        blurRadius: 5.r,
                        offset: Offset(0, 5.r),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppRouter.navigateTo(
                            context,
                            const CustomDoctorView(),
                          );
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000.r),
                              child: Image.asset(
                                Assets.img.doctor2.path,
                                height: 44.w,
                                width: 44.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  child: AppText(
                                    start: 8.w,
                                    text:
                                        AppCubit.get(
                                          context,
                                        ).postsList[index]['doctor_name'] ??
                                        "",
                                    size: 12.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: 200.w,
                                  child: AppText(
                                    start: 8.w,
                                    text: formattedDate,
                                    size: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (AppCubit.get(
                        context,
                      ).postsList[index]['title'].isNotEmpty)
                        SizedBox(
                          width: 300.w,
                          child: AppText(
                            top: 8.h,
                            textAlign: TextAlign.start,
                            text:
                                AppCubit.get(
                                  context,
                                ).postsList[index]['title'] ??
                                "",
                            lines: 100,
                            fontWeight: FontWeight.w600,
                            size: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      if (AppCubit.get(
                        context,
                      ).postsList[index]['content'].isNotEmpty)
                        SizedBox(
                          width: 300.w,
                          child: AppText(
                            top: 8.h,
                            textAlign: TextAlign.start,
                            text:
                                AppCubit.get(
                                  context,
                                ).postsList[index]['content'] ??
                                "",
                            lines: 100,
                            fontWeight: FontWeight.w600,
                            size: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      if (AppCubit.get(context).postsList[index]['image'] !=
                              null &&
                          AppCubit.get(
                            context,
                          ).postsList[index]['image'].isNotEmpty)
                        // SizedBox(
                        //   height: 90.h,
                        //   child: ListView.separated(
                        //     padding: EdgeInsetsDirectional.only(
                        //       top: 16.h,
                        //       end: 16.w,
                        //     ),
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount:
                        //         AppCubit.get(
                        //           context,
                        //         ).postsList[index]['image'].length,
                        //     separatorBuilder:
                        //         (context, imgIndex) => SizedBox(width: 8.w),
                        //     itemBuilder:
                        //         (context, imgIndex) => InkWell(
                        //           splashColor: Colors.transparent,
                        //           highlightColor: Colors.transparent,
                        //           onTap: () {
                        //             showModalBottomSheet(
                        //               backgroundColor: Colors.black,
                        //               isScrollControlled: true,
                        //               context: context,
                        //               builder:
                        //                   (context) => Stack(
                        //                     children: [
                        //                       SizedBox(
                        //                         width: double.infinity,
                        //                         child: PhotoView(
                        //                           backgroundDecoration:
                        //                               const BoxDecoration(
                        //                                 color:
                        //                                     Colors.transparent,
                        //                               ),
                        //                           imageProvider: NetworkImage(
                        //                             AppCubit.get(
                        //                               context,
                        //                             ).postsList[index]['image'][imgIndex],
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       PositionedDirectional(
                        //                         top: 30.h,
                        //                         start: 16.w,
                        //                         child: IconButton(
                        //                           icon: const Icon(
                        //                             Icons.close,
                        //                             color: Colors.white,
                        //                           ),
                        //                           onPressed: () {
                        //                             Navigator.pop(context);
                        //                           },
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //             );
                        //           },
                        //           child: Container(
                        //             height: 90.w,
                        //             width: 90.w,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(12.r),
                        //               color: Colors.white,
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: AppColors.primary.withOpacity(
                        //                     0.2,
                        //                   ),
                        //                   spreadRadius: 1.r,
                        //                   blurRadius: 5.r,
                        //                   offset: Offset(0, 5.r),
                        //                 ),
                        //               ],
                        //             ),
                        //             child: ClipRRect(
                        //               borderRadius: BorderRadius.circular(12.r),
                        //               child: AppCachedImage(
                        //                 image:
                        //                     AppCubit.get(
                        //                       context,
                        //                     ).postsList[index]['image'],
                        //                 height: 90.w,
                        //                 width: 90.w,
                        //                 fit: BoxFit.cover,
                        //               ),
                        //               // Image.network(
                        //               //   AppCubit.get(
                        //               //     context,
                        //               //   ).postsList[index]['image'][imgIndex],
                        //               //   height: 90.w,
                        //               //   width: 90.w,
                        //               //   fit: BoxFit.cover,
                        //               // ),
                        //             ),
                        //           ),
                        //         ),
                        //   ),
                        // ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.black,
                              isScrollControlled: true,
                              context: context,
                              builder:
                                  (context) => Stack(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: PhotoView(
                                          backgroundDecoration:
                                              const BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                          imageProvider: NetworkImage(
                                            AppCubit.get(
                                              context,
                                            ).postsList[index]['image'],
                                          ),
                                        ),
                                      ),
                                      PositionedDirectional(
                                        top: 30.h,
                                        start: 16.w,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: AppCachedImage(
                              image:
                                  AppCubit.get(
                                    context,
                                  ).postsList[index]['image'],
                              height: 120.w,
                              width: 120.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      SizedBox(height: 16.h),
                      DocPostsViews(index: index),
                    ],
                  ),
                );
              },
            );
      },
    );
  }
}
