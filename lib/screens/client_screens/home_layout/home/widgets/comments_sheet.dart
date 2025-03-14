import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';

class CommentsSheet extends StatelessWidget {
  const CommentsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 600.h,
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 16.h),
                  physics: const BouncingScrollPhysics(),
                  itemCount: 20,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder:
                      (context, index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(1000.r),
                            child: Image.asset(
                              Assets.img.doctor2.path,
                              height: 40.w,
                              width: 40.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            width: 200.w,
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(8.r),
                                bottomEnd: Radius.circular(8.r),
                                bottomStart: Radius.circular(8.r),
                              ),
                            ),
                            child: AppText(
                              text:
                                  ' تعليق تعليق تعليق تعليق تعليق تعليق تعليق تعليق تعليق تعليق تعليق تعلي تعليق تعليق تعليق تعليق',
                              size: 16.sp,
                              color: Colors.white,
                              lines: 10,
                            ),
                          ),
                        ],
                      ),
                ),
              ),
              AppInput(
                filled: true,
                hint: 'اكتب تعليقك',
                inputType: TextInputType.text,
                start: 1.w,
                end: 1.w,
                suffixIcon: Icon(
                  Icons.send,
                  color: AppColors.primary,
                  size: 30.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
