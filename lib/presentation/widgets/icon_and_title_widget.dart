import '../../index.dart';

class IconAndTitleWidget extends StatelessWidget {
  const IconAndTitleWidget({
    Key? key,
    this.icon,
    this.color,
    this.iconSize,
    required this.title,
    this.fontSize,
  }) : super(key: key);
  final IconData? icon;
  final Color? color;
  final double? iconSize;
  final String title;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: iconSize ?? getProportionateScreenHeight(16),
            color: color,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: TextWidget(
              text: title,
              fontSize: fontSize ?? getProportionateScreenWidth(15.0),
              maxLines: 1,
              overFlow: TextOverflow.ellipsis,
              color: AppColors.grey.withOpacity(0.70),
            ),
          ),
        ],
      ),
    );
  }
}
