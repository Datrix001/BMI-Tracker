// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsColorsGen {
  const $AssetsColorsGen();

  /// File path: assets/colors/colors.xml
  String get colors => 'assets/colors/colors.xml';

  /// List of all assets
  List<String> get values => [colors];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/NotoSans-ExtraLight.ttf
  String get notoSansExtraLight => 'assets/fonts/NotoSans-ExtraLight.ttf';

  /// File path: assets/fonts/NotoSans-Light.ttf
  String get notoSansLight => 'assets/fonts/NotoSans-Light.ttf';

  /// File path: assets/fonts/NotoSans-SemiBold.ttf
  String get notoSansSemiBold => 'assets/fonts/NotoSans-SemiBold.ttf';

  /// File path: assets/fonts/SourceCodePro-Bold.ttf
  String get sourceCodeProBold => 'assets/fonts/SourceCodePro-Bold.ttf';

  /// File path: assets/fonts/SourceCodePro-Light.ttf
  String get sourceCodeProLight => 'assets/fonts/SourceCodePro-Light.ttf';

  /// File path: assets/fonts/SourceCodePro-SemiBold.ttf
  String get sourceCodeProSemiBold => 'assets/fonts/SourceCodePro-SemiBold.ttf';

  /// List of all assets
  List<String> get values => [
    notoSansExtraLight,
    notoSansLight,
    notoSansSemiBold,
    sourceCodeProBold,
    sourceCodeProLight,
    sourceCodeProSemiBold,
  ];
}

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/eye.png
  AssetGenImage get eye => const AssetGenImage('assets/png/eye.png');

  /// File path: assets/png/forgot_p.png
  AssetGenImage get forgotP => const AssetGenImage('assets/png/forgot_p.png');

  /// File path: assets/png/hidden.png
  AssetGenImage get hidden => const AssetGenImage('assets/png/hidden.png');

  /// File path: assets/png/otp.png
  AssetGenImage get otp => const AssetGenImage('assets/png/otp.png');

  /// List of all assets
  List<AssetGenImage> get values => [eye, forgotP, hidden, otp];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/Apple logo.svg
  String get appleLogo => 'assets/svg/Apple logo.svg';

  /// File path: assets/svg/Google.svg
  String get google => 'assets/svg/Google.svg';

  /// File path: assets/svg/tick.svg
  String get tick => 'assets/svg/tick.svg';

  /// List of all assets
  List<String> get values => [appleLogo, google, tick];
}

class Assets {
  const Assets._();

  static const $AssetsColorsGen colors = $AssetsColorsGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
