import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';

class VideosViews extends StatelessWidget {
  final int index;
  const VideosViews({super.key, required this.index});

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
                  text: '3289',
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
                AppCubit.get(context).changeVideoLoveIndex(index);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.svg.heart,
                    color:
                        AppCubit.get(context).loveVideoIndexes.contains(index)
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
                        AppCubit.get(context).loveVideoIndexes.contains(index)
                            ? Colors.red
                            : const Color(0xffB9B9B9),
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
