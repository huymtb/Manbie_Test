import 'package:flutter/material.dart';
import 'package:manabie_testing/model/todo.dart';
import 'package:manabie_testing/theme/colors.dart';
import 'package:manabie_testing/theme/dimens.dart';
import 'package:manabie_testing/theme/text_style.dart';

class TodoItem extends StatelessWidget {
  final Todo? todo;
  final Function? checkDone;

  const TodoItem({Key? key, this.todo, this.checkDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo!.name!,
                  style: AppTextStyle.todoStyle,
                ),
                Text(
                  todo!.content!,
                  style: AppTextStyle.todoStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimens.textSizeDefault),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              checkDone!();
            },
            child: Padding(
              padding: const EdgeInsets.all(Dimens.defaultPadding),
              child: Icon(
                Icons.check,
                size: Dimens.iconSize,
                color: todo!.status != null && todo!.status!
                    ? AppColors.primary
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
