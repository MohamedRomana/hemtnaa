import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import 'package:hemtnaa/core/widgets/flash_message.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';

class DocPostsViews extends StatelessWidget {
  final int index;
  const DocPostsViews({super.key, required this.index});

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
                AppCubit.get(context).changeLoveIndex(index);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.svg.heart,
                    color:
                        AppCubit.get(context).loveIndexes.contains(index)
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
                        AppCubit.get(context).loveIndexes.contains(index)
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

final _formKey = GlobalKey<FormState>();
final _commentController = TextEditingController();

class Comments extends StatefulWidget {
  final int index;
  const Comments({super.key, required this.index});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  initState() {
    super.initState();
    AppCubit.get(context).getComments(
      postId: AppCubit.get(context).postsList[widget.index]['id'].toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: ListView.separated(
              reverse: true,
              padding: EdgeInsets.only(top: 50.h, bottom: 100.h),
              itemBuilder: (context, index) {
                final realIndex =
                    AppCubit.get(context).comments.length - 1 - index;
                final comment = AppCubit.get(context).comments[realIndex];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 10.w),
                    Container(
                      height: 50.w,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(color: Colors.white, width: 2.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(Assets.img.doctor.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 280.w,
                      padding: EdgeInsets.all(10.r),
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: comment['username'] ?? "USER NAME",
                            color: Colors.white,
                            size: 15.sp,
                            lines: 100,
                            fontWeight: FontWeight.w500,
                            bottom: 5.h,
                          ),
                          AppText(
                            text: comment['comment'] ?? "",
                            color: Colors.white,
                            size: 13.sp,
                            lines: 100,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: AppCubit.get(context).comments.length,
            ),
          ),
          PositionedDirectional(
            bottom: 10.h,
            start: 10.w,
            end: 10.w,
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: 400.w,
                child: AppInput(
                  filled: true,
                  borderColorr: AppColors.primary,
                  color: AppColors.borderColor,
                  controller: _commentController,
                  prefixIcon: Transform.scale(
                    scaleX: -1,
                    child: BlocConsumer<AppCubit, AppState>(
                      listener: (context, state) {
                        if (state is AddCommentSuccess) {
                          AppCubit.get(context).getComments(
                            postId:
                                AppCubit.get(
                                  context,
                                ).postsList[widget.index]['id'].toString(),
                          );
                          _commentController.clear();
                          showFlashMessage(
                            message: state.message,
                            type: FlashMessageType.success,
                            context: context,
                          );
                        } else if (state is AddCommentFailure) {
                          showFlashMessage(
                            message: state.error,
                            type: FlashMessageType.error,
                            context: context,
                          );
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              AppCubit.get(context).addComment(
                                postId:
                                    AppCubit.get(
                                      context,
                                    ).postsList[widget.index]['id'].toString(),
                                comment: _commentController.text,
                              );
                            }
                          },
                          child: const Icon(
                            Icons.send,
                            color: AppColors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                  hint: 'اضافة تعليق',
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'ادخل التعليق';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
