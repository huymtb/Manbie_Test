import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:manabie_testing/theme/colors.dart';
import 'package:manabie_testing/theme/dimens.dart';
import 'package:manabie_testing/utils/ui_utils.dart';

class LoadingContainer extends StatelessWidget {
  final Widget? child;
  final bool isLoading;

  const LoadingContainer(
      {Key? key, @required this.child, this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            color: Colors.white,
            width: getScreenWidth(context),
            height: getScreenHeight(context),
            child: child),
        if (isLoading)
          Container(
              width: getScreenWidth(context),
              height: getScreenHeight(context),
              color: Colors.grey.withOpacity(0.5),
              child: Center(child: loaderContainer()))
      ],
    );
  }

  Widget loaderContainer() {
    return Container(
      width: Dimens.loadingSize,
      height: Dimens.loadingSize,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.all(Radius.circular(Dimens.containerRadius))),
      child: const SpinKitRing(
        color: AppColors.primary,
        lineWidth: Dimens.loadingWidth,
        size: Dimens.iconSize,
      ),
    );
  }
}
