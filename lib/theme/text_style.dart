import 'package:flutter/material.dart';
import 'package:manabie_testing/theme/colors.dart';
import 'package:manabie_testing/theme/dimens.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle defaultStyle = const TextStyle(
      color: AppColors.primary,
      fontSize: Dimens.textSizeDefault);

  static TextStyle todoStyle = const TextStyle(
      color: AppColors.textColor,
      fontSize: Dimens.titleFontSize,
      fontWeight: FontWeight.w700);
}