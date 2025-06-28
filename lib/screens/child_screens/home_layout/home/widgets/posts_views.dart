import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../doctor_screens/home_layout/doc_home/widgets/doc_posts_views.dart';

class PostsViews extends StatelessWidget {
  final int index;
  const PostsViews({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.visibility,
                  color: const Color(0xffB9B9B9),
                  size: 18.sp,
                ),
                AppText(
                  start: 5.w,
                  text:
                      AppCubit.get(
                        context,
                      ).postsList[index]['views'].toString(),
                  size: 11.sp,
                  color: const Color(0xffB9B9B9),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).doLikePost(
                  postId:
                      AppCubit.get(context).postsList[index]['id'].toString(),
                );
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.svg.heart,
                    color:
                        AppCubit.get(context).postsList[index]['likes'] == 1
                            ? Colors.red
                            : const Color(0xffB9B9B9),
                    height: 18.w,
                    width: 18.w,
                    fit: BoxFit.cover,
                  ),
                  AppText(
                    start: 5.w,
                    text: 'اعجاب',
                    size: 11.sp,
                    color:
                        AppCubit.get(context).postsList[index]['likes'] == 1
                            ? Colors.red
                            : const Color(0xffB9B9B9),
                  ),
                ],
              ),
            ),
                        SizedBox(width: 12.w),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Comments(index: index);
                  },
                );
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.svg.chats,
                    color: const Color(0xffB9B9B9),
                    height: 18.w,
                    width: 18.w,
                    fit: BoxFit.cover,
                  ),
                  AppText(
                    start: 5.w,
                    text: 'التعليقات',
                    size: 11.sp,
                    color: const Color(0xffB9B9B9),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
