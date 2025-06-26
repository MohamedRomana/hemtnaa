import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/custom_lottie_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../doc_doctor_view/doctor_view.dart';
import 'doc_posts_views.dart';

class DocPostsList extends StatefulWidget {
  const DocPostsList({super.key});

  @override
  State<DocPostsList> createState() => _DocPostsListState();
}

class _DocPostsListState extends State<DocPostsList> {
  ImageProvider getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('base64:')) {
      final base64Str = imageUrl.replaceFirst('base64:', '');
      return Image.memory(base64Decode(base64Str)).image;
    } else {
      return NetworkImage(imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final posts = AppCubit.get(context).postsList;
        return posts.isEmpty
            ? Column(
              children: [
                SizedBox(height: 100.h),
                CustomLottieWidget(lottieName: Assets.img.notiEmpty),
                AppText(
                  text: "لا يوجد بوستات",
                  size: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ],
            )
            : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              itemCount: posts.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder:
                  (context, index) => Container(
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
                                      text: posts[index].doctorName,
                                      size: 12.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200.w,
                                    child: AppText(
                                      start: 8.w,
                                      text: timeago.format(
                                        posts[index].timestamp,
                                      ),
                                      size: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (posts[index].text.isNotEmpty)
                          SizedBox(
                            width: 300.w,
                            child: AppText(
                              top: 20.h,
                              textAlign: TextAlign.start,
                              text: posts[index].text,
                              lines: 100,
                              fontWeight: FontWeight.w600,
                              size: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                        if (posts[index].imageUrls.isNotEmpty)
                          SizedBox(
                            height: 90.h,
                            child: ListView.separated(
                              padding: EdgeInsetsDirectional.only(
                                top: 16.h,
                                end: 16.w,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: posts[index].imageUrls.length,
                              separatorBuilder:
                                  (context, imgIndex) => SizedBox(width: 8.w),
                              itemBuilder:
                                  (context, imgIndex) => InkWell(
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
                                                          color:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                    imageProvider:
                                                        getImageProvider(
                                                          posts[index]
                                                              .imageUrls[imgIndex],
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
                                    child: Container(
                                      height: 90.w,
                                      width: 90.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withOpacity(0.2),
                                            spreadRadius: 1.r,
                                            blurRadius: 5.r,
                                            offset: Offset(0, 5.r),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        child: Image(
                                          image: getImageProvider(
                                            posts[index].imageUrls[imgIndex],
                                          ),
                                          height: 90.w,
                                          width: 90.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        SizedBox(height: 16.h),
                        DocPostsViews(index: index),
                      ],
                    ),
                  ),
            );
      },
    );
  }
}
