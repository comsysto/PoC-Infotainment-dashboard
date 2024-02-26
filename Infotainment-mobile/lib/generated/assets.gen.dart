/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/battery.png
  AssetGenImage get battery => const AssetGenImage('assets/icons/battery.png');

  /// File path: assets/icons/brake-warning.png
  AssetGenImage get brakeWarning =>
      const AssetGenImage('assets/icons/brake-warning.png');

  /// File path: assets/icons/check-engine.png
  AssetGenImage get checkEngine =>
      const AssetGenImage('assets/icons/check-engine.png');

  /// File path: assets/icons/doors.png
  AssetGenImage get doors => const AssetGenImage('assets/icons/doors.png');

  /// File path: assets/icons/engine-coolant.png
  AssetGenImage get engineCoolant =>
      const AssetGenImage('assets/icons/engine-coolant.png');

  /// File path: assets/icons/fog-light-front.png
  AssetGenImage get fogLightFront =>
      const AssetGenImage('assets/icons/fog-light-front.png');

  /// File path: assets/icons/fog-light-rear.png
  AssetGenImage get fogLightRear =>
      const AssetGenImage('assets/icons/fog-light-rear.png');

  /// File path: assets/icons/high-beam.png
  AssetGenImage get highBeam =>
      const AssetGenImage('assets/icons/high-beam.png');

  /// File path: assets/icons/left-blinker.png
  AssetGenImage get leftBlinker =>
      const AssetGenImage('assets/icons/left-blinker.png');

  /// File path: assets/icons/low-beam.png
  AssetGenImage get lowBeam => const AssetGenImage('assets/icons/low-beam.png');

  /// File path: assets/icons/oil.png
  AssetGenImage get oil => const AssetGenImage('assets/icons/oil.png');

  /// File path: assets/icons/right-blinker.png
  AssetGenImage get rightBlinker =>
      const AssetGenImage('assets/icons/right-blinker.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        battery,
        brakeWarning,
        checkEngine,
        doors,
        engineCoolant,
        fogLightFront,
        fogLightRear,
        highBeam,
        leftBlinker,
        lowBeam,
        oil,
        rightBlinker
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
