import 'package:flutter/cupertino.dart';

import '../../index.dart';

class RowIconAndTitleWidget extends StatelessWidget {
  const RowIconAndTitleWidget({
    Key? key,
    required this.dimensions,
    required this.time,
    this.fontSize,
    this.iconSize,
  }) : super(key: key);
  final String dimensions;
  final String time;
  final double? fontSize;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconAndTitleWidget(
          title: 'Normal',
          fontSize: fontSize,
          icon: CupertinoIcons.circle_fill,
          color: AppColors.iconColor1,
          iconSize: iconSize,
        ),
        IconAndTitleWidget(
          title: dimensions,
          fontSize: fontSize,
          icon: CupertinoIcons.location_solid,
          color: AppColors.primaryColor,
          iconSize: iconSize,
        ),
        IconAndTitleWidget(
          title: time,
          fontSize: fontSize,
          icon: CupertinoIcons.time_solid,
          color: AppColors.iconColor2,
          iconSize: iconSize,
        ),
      ],
    );
  }
}
