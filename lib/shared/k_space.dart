import 'package:flutter/material.dart';

abstract final class KSpace {
  static const tiny = 5.0;
  static const small = 10.0;
  static const double medium = 12;
  static const large = 15.0;
  static const extraLarge = 20.0;
}

const kShrinkSpace = SizedBox.shrink();
const EdgeInsets kScaffoldMargin =
    EdgeInsets.symmetric(horizontal: KSpace.medium);

abstract final class KVerticalSpace {
  static const tiny = SizedBox(height: KSpace.tiny);
  static const small = SizedBox(height: KSpace.small);
  static const medium = SizedBox(height: KSpace.medium);
  static const large = SizedBox(height: KSpace.large);
  static const extraLarge = SizedBox(height: KSpace.extraLarge);
}

abstract final class KHorizontalSpace {
  static const tiny = SizedBox(width: KSpace.tiny);
  static const small = SizedBox(width: KSpace.small);
  static const medium = SizedBox(width: KSpace.medium);
  static const large = SizedBox(width: KSpace.large);
  static const extraLarge = SizedBox(width: KSpace.extraLarge);
}

class HSpacer extends SizedBox {
  const HSpacer(final double size, {super.key}) : super(width: size);
}

class VSpacer extends SizedBox {
  const VSpacer(final double size, {super.key}) : super(height: size);
}
