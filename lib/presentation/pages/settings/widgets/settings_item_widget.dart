import 'package:flutter/cupertino.dart';
import '../../../../index.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.backgroundColor,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.size,
  });
  final IconData icon;
  final String title;
  final Color? backgroundColor;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
              child: Icon(
                icon,
                size: getProportionateScreenHeight(22),
                color: AppColors.white,
              ),
            ),
            title: TextWidget(
              text: title,
              fontSize: getProportionateScreenWidth(14),
              fontWeight: FontWeight.w600,
            ),
            subtitle: TextWidget(
              text: subtitle ?? '',
              fontSize: getProportionateScreenWidth(14),
              color: AppColors.grey.withOpacity(0.6),
            ),
            trailing: trailing ??
                Icon(
                  CupertinoIcons.right_chevron,
                  color: AppColors.grey,
                  size: getProportionateScreenHeight(20),
                ),
          ),
          Divider(color: AppColors.grey.withOpacity(0.4)),
        ],
      ),
    );
  }
}
