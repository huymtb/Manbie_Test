import 'package:flutter/material.dart';
import 'package:manabie_testing/res/file/strings.dart';
import 'package:manabie_testing/theme/dimens.dart';
import 'package:manabie_testing/theme/text_style.dart';

class NoTodoItem extends StatelessWidget {
  const NoTodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppText.noTodo,
        style:
            AppTextStyle.defaultStyle.copyWith(fontSize: Dimens.appBarTextSize),
      ),
    );
  }
}
