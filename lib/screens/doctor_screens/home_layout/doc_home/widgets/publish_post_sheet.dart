import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/widgets/app_cached.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';

final _posttitleController = TextEditingController();
final _postController = TextEditingController();

class PublishPostSheet extends StatefulWidget {
  const PublishPostSheet({super.key});

  @override
  State<PublishPostSheet> createState() => _PublishPostSheetState();
}

class _PublishPostSheetState extends State<PublishPostSheet> {
  @override
  void initState() {
    _posttitleController.clear();
    _postController.clear();
    AppCubit.get(context).postImages = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: 800.h,
            padding: EdgeInsets.all(24.r),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20.r),
                topEnd: Radius.circular(20.r),
              ),
            ),
            child: SingleChildScrollView(
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
                        child: AppCachedImage(
                          image:
                              AppCubit.get(
                                context,
                              ).userMap["profile_picture"] ??
                              '',
                          height: 50.w,
                          width: 50.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      AppText(
                        text:
                            "${AppCubit.get(context).userMap["first_name"]} ${AppCubit.get(context).userMap["last_name"]}",
                        size: 16.sp,
                        fontWeight: FontWeight.w500,
                        start: 12.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  AppInput(
                    filled: true,
                    controller: _posttitleController,
                    focusedBorderColor: Colors.transparent,
                    hint: 'اسم الموضوع',
                    maxLines: 2,
                    start: 0,
                    end: 0,
                    enabledBorderColor: Colors.transparent,
                    color: Colors.transparent,
                  ),
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
                                      AppCubit.get(
                                        context,
                                      ).removePostImage(index);
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

                  BlocConsumer<AppCubit, AppState>(
                    listener: (context, state) {
                      if (state is CreatePostSuccess) {
                        Navigator.pop(context);
                        showFlashMessage(
                          message: state.message,
                          type: FlashMessageType.success,
                          context: context,
                        );
                      } else if (state is CreatePostFailure) {
                        showFlashMessage(
                          message: state.error,
                          type: FlashMessageType.error,
                          context: context,
                        );
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        start: 180.w,
                        bottom: 10.h,
                        width: 85.w,
                        radius: 8.r,
                        onPressed: () {
                          AppCubit.get(context).createPosts(
                            title: _posttitleController.text,
                            content: _postController.text,
                            category: 'A',
                            doctorId: '1',
                          );
                        },
                        top: 50.h,
                        child:
                            state is CreatePostLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : AppText(
                                  text: 'نشر',
                                  size: 22.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      );
                    },
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

// class PostModel {
//   final String doctorName;
//   final String text;
//   final List<String> imageUrls;
//   final DateTime timestamp;

//   PostModel({
//     required this.doctorName,
//     required this.text,
//     required this.imageUrls,
//     required this.timestamp,
//   });

//   // لإنشاء كائن من خريطة JSON
//   factory PostModel.fromMap(Map<String, dynamic> map) {
//     return PostModel(
//       doctorName: map['doctorName'] ?? 'بدون اسم',
//       text: map['text'] ?? '',
//       imageUrls: List<String>.from(map['images'] ?? []),
//       timestamp: _parseTimestamp(map['timestamp']),
//     );
//   }

//   // لتحويل الكائن إلى JSON عند الحفظ
//   Map<String, dynamic> toMap() {
//     return {
//       'doctorName': doctorName,
//       'text': text,
//       'images': imageUrls,
//       'timestamp': timestamp.toIso8601String(),
//     };
//   }

//   // دعم timestamp كـ String أو DateTime أو Timestamp من Firebase
//   static DateTime _parseTimestamp(dynamic rawTimestamp) {
//     if (rawTimestamp is String) {
//       return DateTime.tryParse(rawTimestamp) ?? DateTime.now();
//     } else if (rawTimestamp is DateTime) {
//       return rawTimestamp;
//     } else if (rawTimestamp is Timestamp) {
//       return rawTimestamp.toDate();
//     } else {
//       return DateTime.now();
//     }
//   }
// }
