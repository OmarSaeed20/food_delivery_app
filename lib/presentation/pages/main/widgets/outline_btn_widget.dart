import '../../../../index.dart';

class OutlineBtnWidget extends StatelessWidget {
  const OutlineBtnWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: getProportionateScreenHeight(10),
        bottom: getProportionateScreenHeight(10),
        end: getProportionateScreenWidth(15),
      ),
      child: InkWell(
        borderRadius: AppConstants.borderRadius * 3,
        onTap: onTap as void Function(),
        child: Container(
          padding: EdgeInsetsDirectional.only(
            start: getProportionateScreenWidth(15),
            end: getProportionateScreenWidth(15),
          ),
          decoration: BoxDecoration(
            borderRadius: AppConstants.borderRadius * 3,
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: Center(
            child: Row(
              children: [
                TextWidget(
                  text: title,
                  color: AppColors.primaryColor,
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.w600,
                ),
                AppConstants.kWidthBox5,
                Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: getProportionateScreenHeight(18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
