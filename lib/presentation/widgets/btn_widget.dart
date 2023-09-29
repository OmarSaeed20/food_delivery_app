import '../../index.dart';

class BtnWidget extends StatelessWidget {
  const BtnWidget({
    Key? key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.fontSize,
    this.height,
    this.width,
    this.radius,
    this.isLoading = false,
  }) : super(key: key);
  final String title;

  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final double? radius;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? getProportionateScreenHeight(45),
      width: width ?? Dimensions.screenWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? AppColors.transparent),
            borderRadius: BorderRadius.circular(radius ?? 4),
          ),
          elevation: 0.0,
          shadowColor: AppColors.transparent,
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
        ),
        onPressed: onPressed,
        child: isLoading
            ? const Center(child: LoadingWidget())
            : TextWidget(
                text: title,
                color: titleColor ?? AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: fontSize ?? getProportionateScreenWidth(16),
              ),
      ),
    );
  }
}
