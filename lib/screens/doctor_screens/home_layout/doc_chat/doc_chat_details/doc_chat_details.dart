import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_doc_bottom_nav.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'widgets/doc_chat_header.dart';

final _messageSendController = TextEditingController();

class DocChatDetails extends StatefulWidget {
  const DocChatDetails({super.key});

  @override
  State<DocChatDetails> createState() => _DocChatDetailsState();
}

class _DocChatDetailsState extends State<DocChatDetails>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0.0) {
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
          onWillPop: () async {
            bool? shouldPop = await showDialog<bool>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text(
                      LocaleKeys.doYouWantToLeaveThisApp.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      LocaleKeys.areYouSure.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => SystemNavigator.pop(),
                        child: Text(LocaleKeys.yes.tr()),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(LocaleKeys.no.tr()),
                      ),
                    ],
                  ),
            );
            return shouldPop ?? false;
          },
          child: Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppInput(
        controller: _messageSendController,
        enabledBorderColor: Colors.grey,
        filled: true,
        suffixIcon: GestureDetector(
          onTap: () {
            if (_messageSendController.text.trim().isNotEmpty) {
              _sendMessage();
              _messageSendController.clear();
            }
          },
          child: Icon(Icons.send, color: AppColors.primary, size: 30.sp),
        ),
        hint: 'اكتب رسالة',
      ),

      bottomNavigationBar: const CustomDocBottomNav(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DocChatHeader(),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.only(bottom: 120.h),
              itemCount: 5,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 18.h),
              itemBuilder:
                  (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          index.isEven
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                      children: [
                        index.isEven
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.asset(
                                Assets.img.doctor2.path,
                                height: 40.w,
                                width: 40.w,
                              ),
                            )
                            : const SizedBox.shrink(),
                        Container(
                          padding: EdgeInsets.all(12.r),
                          margin: EdgeInsetsDirectional.only(
                            start: 6.w,
                            end: 6.w,
                          ),
                          decoration: BoxDecoration(
                            color:
                                index.isEven
                                    ? AppColors.primary
                                    : const Color(0xffD7E4F9),
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd:
                                  index.isEven
                                      ? Radius.circular(8.r)
                                      : Radius.zero,
                              topStart:
                                  index.isEven
                                      ? Radius.zero
                                      : Radius.circular(8.r),
                              bottomEnd: Radius.circular(8.r),
                              bottomStart: Radius.circular(8.r),
                            ),
                          ),
                          child: SizedBox(
                            width: 250.w,
                            child: AppText(
                              text:
                                  'حسنًا، لنبدأ! أنا سأقول كلمة وأريدك أن تكررها  حسنًا، لنبدأ! أنا سأقول كلمة وأريدك أن تكررها بعدي، حسنا؟بعدي، حسنا؟ ',
                              lines: 5,
                              size: 14.sp,
                              color: index.isEven ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        index.isOdd
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.asset(
                                Assets.img.doctor.path,
                                height: 40.w,
                                width: 40.w,
                              ),
                            )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
            ),
          ),
        ],
      ),
    ));
  }
}

