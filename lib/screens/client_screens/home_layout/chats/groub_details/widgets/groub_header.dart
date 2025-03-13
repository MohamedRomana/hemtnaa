import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../../gen/assets.gen.dart';

Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> statuses =
      await [Permission.camera, Permission.microphone].request();

  if (statuses[Permission.camera]!.isDenied ||
      statuses[Permission.microphone]!.isDenied) {
    debugPrint(" المستخدم رفض الأذونات! لا يمكن تشغيل الكاميرا.");
    return;
  }

  debugPrint(" الأذونات مُعطاة، يمكنك تشغيل الكاميرا.");
}

class GroubHeader extends StatelessWidget {
  const GroubHeader({super.key});

  @override
  Widget build(BuildContext context) {
    void startVideoCall() async {
      await requestPermissions();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => ZegoUIKitPrebuiltCall(
                appID: 123456789,
                appSign: 'your_app_sign',
                callID: 'chat123',
                userID: 'user1',
                userName: 'User One',
                config:
                    ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                      ..turnOnCameraWhenJoining = true
                      ..turnOnMicrophoneWhenJoining = true
                      ..bottomMenuBar = ZegoCallBottomMenuBarConfig(
                        isVisible: true,
                        buttons: [
                          ZegoCallMenuBarButtonName.toggleCameraButton,
                          ZegoCallMenuBarButtonName.toggleMicrophoneButton,
                          ZegoCallMenuBarButtonName.hangUpButton,
                          ZegoCallMenuBarButtonName.switchAudioOutputButton,
                          ZegoCallMenuBarButtonName.switchCameraButton,
                        ],
                      ),
              ),
        ),
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          margin: EdgeInsets.only(top: 60.h),
          decoration: const BoxDecoration(color: Color(0xffFAFAFA)),
          child: Row(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: AppText(
                      text: 'احمد محمد',
                      size: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: AppText(
                      text: '8:00 صباحًا',
                      size: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      makePhoneCall2('011111111111111');
                    },
                    child: SvgPicture.asset(
                      Assets.svg.phone,
                      height: 24.h,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      startVideoCall();
                    },
                    child: SvgPicture.asset(
                      Assets.svg.videoCall,
                      height: 24.h,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> makePhoneCall2(String phoneNumber) async {
  final Uri phoneUri = Uri.parse('tel:$phoneNumber');

  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'تعذر إجراء المكالمة: $phoneNumber';
  }
}
