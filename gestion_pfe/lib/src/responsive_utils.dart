import 'package:flutter/material.dart';

const int extralargeScreenSize = 1493;
const int largeScreenSize = 1023;
const int mediumScreenSize = 767;
const int smallSceenSize = 424;
const int extrasmallSceenSize = 360;

bool isExtraSmallScreen(BuildContext context) {
  //print("extra small");
  return MediaQuery.of(context).size.width < smallSceenSize;
}

bool isSmallScreen(BuildContext context) {
  //print("small");
  return MediaQuery.of(context).size.width >= smallSceenSize &&
      MediaQuery.of(context).size.width < mediumScreenSize;
}

bool isMediumScreen(BuildContext context) {
  //print("meduim");
  return MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width < largeScreenSize;
}

bool isLargeScreen(BuildContext context) {
  //print("large");
  return MediaQuery.of(context).size.width >= largeScreenSize &&
      MediaQuery.of(context).size.width < extralargeScreenSize;
}

bool isExtraLargeScreen(BuildContext context) {
  //print("extra large");
  return MediaQuery.of(context).size.width >= extralargeScreenSize;
}

double getResponsiveDouble(
    {BuildContext? context,
    double? extraSmall,
    double? small,
    double? medium,
    double? large,
    double? extraLarge}) {
  if (isExtraSmallScreen(context!)) {
    return extraSmall!;
  } else if (isSmallScreen(context)) {
    return small!;
  } else if (isMediumScreen(context)) {
    return medium!;
  } else if (isLargeScreen(context)) {
    return large!;
  } else if (isExtraLargeScreen(context)) {
    return extraLarge!;
  } else {
    return large!;
  }
}
