import 'package:flutter/material.dart';
import 'package:manabie_testing/theme/colors.dart';
import 'package:manabie_testing/theme/dimens.dart';

class BottomBarWidget extends StatelessWidget {
  final String? icon;
  final bool isSelected;
  final Function? onPressed;

  const BottomBarWidget(
      {Key? key,
        @required this.icon,
        this.isSelected = false,
        @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        icon!,
        color: isSelected ? AppColors.primary : Colors.black,
        width: Dimens.bottomBarIconSize,
        height: Dimens.bottomBarIconSize,
      ),
      onPressed: () {
        onPressed!();
      },
    );
  }
}
