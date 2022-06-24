import 'package:flutter/widgets.dart';
import 'package:gestion_pfe/src/responsive_utils.dart';
import 'package:gestion_pfe/src/size_config.dart';

Widget resiseWidget({BuildContext? context, Widget? child}) {
  return SizedBox(
      width: getResponsiveDouble(
          context: context,
          extraSmall: SizeConfig.safeBlockHorizontal! * 90,
          small: SizeConfig.safeBlockHorizontal! * 80,
          medium: SizeConfig.safeBlockHorizontal! * 70,
          large: SizeConfig.safeBlockHorizontal! * 60,
          extraLarge: SizeConfig.safeBlockHorizontal! * 50),
      child: child);
}
