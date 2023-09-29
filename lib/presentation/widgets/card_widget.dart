import '../../index.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    this.height,
    this.margin,
    this.padding,
    this.radius,
    required this.child,
  }) : super(key: key);
  final double? height;
  final EdgeInsetsDirectional? margin;
  final EdgeInsetsDirectional? padding;
  final BorderRadius? radius;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? getProportionateScreenHeight(100),
      width: Dimensions.screenWidth,
      margin: margin ??
          EdgeInsetsDirectional.fromSTEB(
            getProportionateScreenWidth(20),
            getProportionateScreenHeight(0),
            getProportionateScreenWidth(20),
            getProportionateScreenHeight(30),
          ),
      padding: padding ??
          EdgeInsetsDirectional.fromSTEB(
            getProportionateScreenWidth(15),
            getProportionateScreenHeight(10),
            getProportionateScreenWidth(15),
            getProportionateScreenHeight(10),
          ),
      decoration: BoxDecoration(
        borderRadius: radius ?? AppConstants.borderRadius,
        color: AppColors.white,
        boxShadow: AppConstants.boxShadow,
      ),
      child: child,
    );
  }
}
