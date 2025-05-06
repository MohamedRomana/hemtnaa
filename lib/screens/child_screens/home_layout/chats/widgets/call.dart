import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key, required this.callID});
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

class CallVideoPage extends StatelessWidget {
  const CallVideoPage({super.key, required this.callID});
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

class GroubCallPage extends StatelessWidget {
  const GroubCallPage({super.key, required this.callID});
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

class GroubCallVideoPage extends StatelessWidget {
  const GroubCallVideoPage({super.key, required this.callID});
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
