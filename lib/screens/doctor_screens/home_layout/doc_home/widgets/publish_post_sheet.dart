import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';

final _postController = TextEditingController();

class PublishPostSheet extends StatefulWidget {
  const PublishPostSheet({super.key});

  @override
  State<PublishPostSheet> createState() => _PublishPostSheetState();
}

class _PublishPostSheetState extends State<PublishPostSheet> {
  @override
  void initState() {
    _postController.clear();
    AppCubit.get(context).postImages = [];
    AppCubit.get(context).postVideos = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(24.r),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20.r),
                  topEnd: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Transform.scale(
                          scaleX: -1,
                          child: Icon(Icons.arrow_forward_ios, size: 24.sp),
                        ),
                      ),
                      AppText(
                        start: 8.w,
                        text: 'انشاء منشور',
                        size: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000.r),
                        child: Image.asset(
                          Assets.img.doctor2.path,
                          height: 50.w,
                          width: 50.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      AppText(
                        text: 'د/ محمد احمد',
                        size: 16.sp,
                        fontWeight: FontWeight.w500,
                        start: 12.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  AppInput(
                    filled: true,
                    controller: _postController,
                    focusedBorderColor: Colors.transparent,
                    hint: 'بماذا تفكر؟ ',
                    maxLines: 10,
                    start: 0,
                    end: 0,
                    enabledBorderColor: Colors.transparent,
                    color: Colors.transparent,
                  ),
                  SizedBox(height: 24.h),
                  AppCubit.get(context).postImages.isNotEmpty
                      ? SizedBox(
                        height: 120.h,
                        child: ListView.separated(
                          padding: EdgeInsets.only(bottom: 16.h),
                          itemCount:
                              AppCubit.get(context).postImages.isNotEmpty
                                  ? AppCubit.get(context).postImages.length
                                  : 0,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder:
                              (context, index) => SizedBox(width: 16.w),
                          itemBuilder: (context, index) {
                            final imageFile =
                                AppCubit.get(context).postImages[index];
            
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  clipBehavior: Clip.none,
                                  height: 120.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                      image: FileImage(imageFile),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                PositionedDirectional(
                                  start: -13.w,
                                  top: -13.h,
                                  child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).removePostImage(index);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 24.sp,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                      : const SizedBox.shrink(),
            
            
                  InkWell(
                    onTap: () {
                      AppCubit.get(context).getPostImages(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image, color: Colors.green, size: 30.sp),
                        AppText(
                          start: 8.w,
                          text: 'صورة',
                          size: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Divider(),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).getPostVideos(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.video_call, color: Colors.red, size: 30.sp),
                        AppText(
                          start: 8.w,
                          text: 'فيديو',
                          size: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  AppButton(
                    start: 180.w,
                    bottom: 10.h,
                    width: 85.w,
                    radius: 8.r,
                    onPressed: () {},
                    top: 50.h,
                    child: AppText(
                      text: 'نشر',
                      size: 22.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
