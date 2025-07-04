import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/widgets/app_button.dart';
import 'package:hemtnaa/core/widgets/flash_message.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_doc_bottom_nav.dart';

class AddActivity extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController statusController;
  final TextEditingController endDateController;
  final TextEditingController startDateController;
  final TextEditingController descriptionController;
  final TextEditingController childNameController;
  const AddActivity({
    super.key,
    required this.nameController,
    required this.statusController,
    required this.endDateController,
    required this.startDateController,
    required this.descriptionController,
    required this.formKey,
    required this.childNameController,
  });

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  @override
  void initState() {
    widget.nameController.clear();
    widget.statusController.clear();
    widget.endDateController.clear();
    widget.startDateController.clear();
    widget.descriptionController.clear();
    AppCubit.get(context).activityImage = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const CustomDocBottomNav(),
          body: Form(
            key: widget.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
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
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 24.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        AppText(
                          start: 8.w,
                          text: 'اضافة نشاط ',
                          size: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    AppText(
                      top: 8.h,
                      text: 'اسم النشاط',
                      bottom: 8.h,
                      size: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    AppInput(
                      start: 0,
                      end: 0,
                      filled: true,
                      enabledBorderColor: Colors.grey,
                      border: 8.r,
                      hint: 'اسم النشاط',
                      controller: widget.nameController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل اسم النشاط';
                        }
                        return null;
                      },
                    ),
                    AppText(
                      top: 8.h,
                      text: 'حالة الطفل',
                      bottom: 8.h,
                      size: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    AppInput(
                      start: 0,
                      end: 0,
                      filled: true,
                      enabledBorderColor: Colors.grey,
                      border: 8.r,
                      hint: 'حالة الطفل',
                      controller: widget.statusController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل حالة الطفل';
                        }
                        return null;
                      },
                    ),
                    AppText(
                      top: 8.h,
                      text: 'تاريخ البدايه',
                      bottom: 8.h,
                      size: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    AppInput(
                      start: 0,
                      end: 0,
                      filled: true,
                      controller: widget.startDateController,
                      enabledBorderColor: Colors.grey,
                      suffixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                        size: 24.sp,
                      ),
                      border: 8.r,
                      hint: 'تاريخ البدايه',
                      read: true,
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          builder:
                              (context, child) => Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: AppColors.primary,
                                    onPrimary: Colors.white,
                                    surface: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                ),
                                child: child!,
                              ),
                        );
                        if (dateTime != null) {
                          String formattedDate = DateFormat(
                            'yyyy-MM-dd',
                          ).format(dateTime);
                          setState(() {
                            widget.startDateController.text = formattedDate;
                          });
                        }
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل تاريخ البدايه';
                        }
                        return null;
                      },
                    ),
                    AppText(
                      top: 8.h,
                      text: 'تاريخ الانتهاء',
                      bottom: 8.h,
                      size: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    AppInput(
                      start: 0,
                      end: 0,
                      filled: true,
                      enabledBorderColor: Colors.grey,
                      border: 8.r,
                      hint: 'تاريخ الانتهاء',
                      controller: widget.endDateController,
                      suffixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                        size: 24.sp,
                      ),
                      read: true,
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          builder:
                              (context, child) => Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: AppColors.primary,
                                    onPrimary: Colors.white,
                                    surface: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                ),
                                child: child!,
                              ),
                        );
                        if (dateTime != null) {
                          String formattedDate = DateFormat(
                            'yyyy-MM-dd',
                          ).format(dateTime);
                          setState(() {
                            widget.endDateController.text = formattedDate;
                          });
                        }
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل تاريخ الانتهاء';
                        }
                        return null;
                      },
                    ),

                    AppText(
                      top: 8.h,
                      text: 'شرح النشاط',
                      bottom: 8.h,
                      size: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    AppInput(
                      start: 0,
                      end: 0,
                      filled: true,
                      enabledBorderColor: Colors.grey,
                      border: 8.r,
                      hint: 'شرح النشاط',
                      controller: widget.descriptionController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل شرح النشاط';
                        }
                        return null;
                      },
                    ),
                    AppText(
                      top: 8.h,
                      text: 'صورة النشاط',
                      bottom: 8.h,
                      size: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    Center(
                      child: Column(
                        children: [
                          AppCubit.get(context).activityImage.isNotEmpty
                              ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Container(
                                      height: 132.w,
                                      width: 312.w,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(
                                            AppCubit.get(
                                              context,
                                            ).activityImage.first,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    end: 0,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        AppCubit.get(
                                          context,
                                        ).removeActivityImage();
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                              : InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  AppCubit.get(
                                    context,
                                  ).getActivityImage(context);
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(10.r),
                                  color: Colors.grey,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: SizedBox(
                                      height: 132.w,
                                      width: 312.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 40.sp,
                                            color: Colors.grey,
                                          ),
                                          AppText(
                                            top: 10.h,
                                            text: 'اضافة صورة النشاط',
                                            size: 12.sp,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                    Center(
                      child: BlocConsumer<AppCubit, AppState>(
                        listener: (context, state) {
                          if (state is AddActivitySuccess) {
                            Navigator.pop(context);
                            showFlashMessage(
                              message: state.message,
                              type: FlashMessageType.success,
                              context: context,
                            );
                            widget.nameController.clear();
                            widget.statusController.clear();
                            widget.endDateController.clear();
                            widget.startDateController.clear();
                            widget.descriptionController.clear();
                            AppCubit.get(context).activityImage = [];
                          } else if (state is AddActivityFailure) {
                            showFlashMessage(
                              message: state.error,
                              type: FlashMessageType.error,
                              context: context,
                            );
                          }
                        },
                        builder: (context, state) {
                          return AppButton(
                            top: 24.h,
                            onPressed: () {
                              if (widget.formKey.currentState!.validate()) {
                                AppCubit.get(context).addActivity(
                                  activityName: widget.nameController.text,
                                  childName: widget.childNameController.text,
                                  details: widget.descriptionController.text,
                                  startDate: widget.endDateController.text,
                                  endDate: widget.endDateController.text,
                                );
                              }
                            },
                            child:
                                state is AddActivityLoading
                                    ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : AppText(
                                      text: 'تاكيد',
                                      size: 21.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ActivityModel {
  final String name;
  final String status;
  final String startDate;
  final String endDate;
  final String description;
  final String imageBase64; // أو imageUrl لو هترفعه على سيرفر

  ActivityModel({
    required this.name,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.imageBase64,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'status': status,
    'startDate': startDate,
    'endDate': endDate,
    'description': description,
    'image': imageBase64,
  };

  factory ActivityModel.fromMap(Map<String, dynamic> map) => ActivityModel(
    name: map['name'],
    status: map['status'],
    startDate: map['startDate'],
    endDate: map['endDate'],
    description: map['description'],
    imageBase64: map['image'],
  );
}
