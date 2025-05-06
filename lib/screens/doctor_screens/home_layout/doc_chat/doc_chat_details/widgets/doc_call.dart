import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class DocCallPage extends StatelessWidget {
  const DocCallPage({super.key, required this.callID});
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1307873913,
      appSign:
          "4730f81b09b3212b6d88054dc3359b1e95efca5366f089d589c53608388c1a44",
      userID: 'user_id',
      userName: 'user_name',
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}

class DocCallVideoPage extends StatelessWidget {
  const DocCallVideoPage({super.key, required this.callID});
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1307873913,
      appSign:
          "4730f81b09b3212b6d88054dc3359b1e95efca5366f089d589c53608388c1a44",
      userID: 'user_id',
      userName: 'user_name',
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}

class DocGroubCallPage extends StatelessWidget {
  const DocGroubCallPage({super.key, required this.callID});
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1307873913,
      appSign:
          "4730f81b09b3212b6d88054dc3359b1e95efca5366f089d589c53608388c1a44",
      userID: 'user_id',
      userName: 'user_name',
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.groupVoiceCall(),
    );
  }
}

class DocGroubCallVideoPage extends StatelessWidget {
  const DocGroubCallVideoPage({super.key, required this.callID});
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1307873913,
      appSign:
          "4730f81b09b3212b6d88054dc3359b1e95efca5366f089d589c53608388c1a44",
      userID: 'user_id',
      userName: 'user_name',
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.groupVideoCall(),
    );
  }
}
