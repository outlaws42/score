import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';

class Screen {
  static double get _ppi => (Platform.isAndroid || Platform.isIOS) ? 150 : 96;
  static bool isLandscape(BuildContext c) =>
      MediaQuery.of(c).orientation == Orientation.landscape;
  //PIXELS
  static Size size(BuildContext c) => MediaQuery.of(c).size;
  static double width(BuildContext c) => size(c).width;
  static double height(BuildContext c) => size(c).height;
  static double devicePixelRatio(BuildContext c) =>
      MediaQuery.of(c).devicePixelRatio;
  static double shortestSide(BuildContext c) =>
      MediaQuery.of(c).size.shortestSide;
  static double diagonal(BuildContext c) {
    Size s = size(c);
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  //INCHES
  static Size inches(BuildContext c) {
    Size pxSize = size(c);
    return Size(pxSize.width / _ppi, pxSize.height / _ppi);
  }

  static double widthInches(BuildContext c) => inches(c).width;
  static double heightInches(BuildContext c) => inches(c).height;
  static double diagonalInches(BuildContext c) => diagonal(c) / _ppi;

  // Bingo Card Specific
  static double calHeight(BuildContext c) {
    Size s = size(c);
    double ratio = devicePixelRatio(c);
    return (s.height - kToolbarHeight - 24) / ratio;
  }

  static double calWidth(BuildContext c) {
    Size s = size(c);
    double ratio = devicePixelRatio(c);
    bool isPhone = s.shortestSide < 480;
    // All Phones
    if (isPhone) {
      print('Device: Phone');
      return (s.width - kToolbarHeight - 24) / ratio;
    }
    // IOS Tablet
    else if (Platform.isIOS) {
      print('Device: iPad');
      return s.width / ratio;
    } else {
      return (s.width - kToolbarHeight) / ratio;
    }
  }

  static double twoCardWidth(
    bool islandscape,
    bool twoCards,
    BuildContext c,
  ) {
    Size s = size(c);
    bool isPhone = s.shortestSide < 480;
    double height = calHeight(c);
    double width = calWidth(c);
    double ratio = devicePixelRatio(c);
    print('calHeight: $height calWidth: $width Ratio: $ratio');
    // Pixel 4, Nexus 4, iPhone 11 pro,
    if (isPhone && ratio > 2.0 && width > 200 && width < 275 ||
        isPhone && ratio > 3.0 && width < 200) {
      return 290;
    } else if (isPhone && !Platform.isIOS && ratio <= 2.0 && width > 265) {
      return 255;
    }
    // iPhone 11 Pro Max, iPhone 11
    else if (Platform.isIOS && height < 135 || isPhone && width > 400) {
      return 325;
    } else {
      return width;
    }
  }
}
