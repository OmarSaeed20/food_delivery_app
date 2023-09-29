import '../../index.dart';

class IconBtnWidget extends StatelessWidget {
  const IconBtnWidget({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.height,
    this.width,
    this.backgroundColor,
    this.radius,
    this.color,
    this.size,
  }) : super(key: key);
  final Function onPressed;
  final IconData icon;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double? radius;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(45),
      width: getProportionateScreenHeight(45),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.offWhite,
        borderRadius:
            BorderRadius.circular(radius ?? getProportionateScreenHeight(45)),
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed as void Function(),
          icon: Icon(
            icon,
            color: color ?? AppColors.black,
            size: size ?? getProportionateScreenHeight(18),
          ),
        ),
      ),
    );
  }
}
