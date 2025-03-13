/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsLangGen {
  const $AssetsLangGen();

  /// File path: assets/Lang/ar.json
  String get ar => 'assets/Lang/ar.json';

  /// File path: assets/Lang/en.json
  String get en => 'assets/Lang/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Lexend-Bold.ttf
  String get lexendBold => 'assets/fonts/Lexend-Bold.ttf';

  /// File path: assets/fonts/Lexend-Light.ttf
  String get lexendLight => 'assets/fonts/Lexend-Light.ttf';

  /// File path: assets/fonts/Lexend-Medium.ttf
  String get lexendMedium => 'assets/fonts/Lexend-Medium.ttf';

  /// File path: assets/fonts/Poppins-Bold.ttf
  String get poppinsBold => 'assets/fonts/Poppins-Bold.ttf';

  /// File path: assets/fonts/Poppins-Light.ttf
  String get poppinsLight => 'assets/fonts/Poppins-Light.ttf';

  /// File path: assets/fonts/Poppins-Medium.ttf
  String get poppinsMedium => 'assets/fonts/Poppins-Medium.ttf';

  /// List of all assets
  List<String> get values => [
    lexendBold,
    lexendLight,
    lexendMedium,
    poppinsBold,
    poppinsLight,
    poppinsMedium,
  ];
}

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/alert.json
  String get alert => 'assets/img/alert.json';

  /// File path: assets/img/doctor.png
  AssetGenImage get doctor => const AssetGenImage('assets/img/doctor.png');

  /// File path: assets/img/emptyseach.json
  String get emptyseach => 'assets/img/emptyseach.json';

  /// File path: assets/img/loading.json
  String get loading => 'assets/img/loading.json';

  /// File path: assets/img/login.json
  String get login => 'assets/img/login.json';

  /// File path: assets/img/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/img/logo.png');

  /// File path: assets/img/noti_empty.json
  String get notiEmpty => 'assets/img/noti_empty.json';

  /// File path: assets/img/onboarding.png
  AssetGenImage get onboarding =>
      const AssetGenImage('assets/img/onboarding.png');

  /// File path: assets/img/senior.png
  AssetGenImage get senior => const AssetGenImage('assets/img/senior.png');

  /// File path: assets/img/start.json
  String get start => 'assets/img/start.json';

  /// File path: assets/img/student.png
  AssetGenImage get student => const AssetGenImage('assets/img/student.png');

  /// List of all assets
  List<dynamic> get values => [
    alert,
    doctor,
    emptyseach,
    loading,
    login,
    logo,
    notiEmpty,
    onboarding,
    senior,
    start,
    student,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsLangGen lang = $AssetsLangGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImgGen img = $AssetsImgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
