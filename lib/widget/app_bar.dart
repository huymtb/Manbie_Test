import 'package:flutter/material.dart';
import 'package:manabie_testing/theme/dimens.dart';
import 'package:manabie_testing/theme/text_style.dart';

class AppBarWidget extends StatelessWidget {
  final String? title;

  const AppBarWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.defaultPadding),
        child: Center(
          child: Text(
            title!,
            style: AppTextStyle.defaultStyle
                .copyWith(fontSize: Dimens.appBarTextSize),
          ),
        ),
      ),
    );
  }
}
