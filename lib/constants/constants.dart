import '../index.dart';

class AppConstants {
  // sized box height , width
  static final kHeightBox5 = SizedBox(height: getProportionateScreenHeight(5));
  static final kHeightBox10 =
      SizedBox(height: getProportionateScreenHeight(10));
  static final kHeightBox15 =
      SizedBox(height: getProportionateScreenHeight(15));
  static final kHeightBox20 =
      SizedBox(height: getProportionateScreenHeight(20));
  static final kHeightBox40 =
      SizedBox(height: getProportionateScreenHeight(40));
  static final kWidthBox5 = SizedBox(width: getProportionateScreenWidth(5));
  static final kWidthBox10 = SizedBox(width: getProportionateScreenWidth(10));
  static final kWidthBox15 = SizedBox(width: getProportionateScreenWidth(15));
  static final kWidthBox20 = SizedBox(width: getProportionateScreenWidth(20));

  // box shadow
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      color: AppColors.grey.withOpacity(0.15),
      blurRadius: 10,
      offset: const Offset(-2, 2), // changes position of shadow
    ),
  ];

  // radius circular
  static BorderRadius borderRadius =
      BorderRadius.circular(getProportionateScreenHeight(10));
  // radius topLeft and topRight
  static BorderRadius borderRadiusTLTR = BorderRadius.only(
    topLeft: Radius.circular(getProportionateScreenHeight(20)),
    topRight: Radius.circular(getProportionateScreenHeight(20)),
  );

  // Padding
  // padding start and end
  static EdgeInsetsDirectional paddingSE = EdgeInsetsDirectional.only(
    start: getProportionateScreenWidth(15),
    end: getProportionateScreenWidth(15),
  );
  // padding top and bottom
  static EdgeInsetsDirectional paddingTB = EdgeInsetsDirectional.only(
    top: getProportionateScreenHeight(20),
    bottom: getProportionateScreenHeight(20),
  );
  // padding start, top, end and bottom
  static EdgeInsetsDirectional paddingSTEB = EdgeInsetsDirectional.only(
    start: getProportionateScreenWidth(15),
    top: getProportionateScreenHeight(20),
    end: getProportionateScreenWidth(15),
    bottom: getProportionateScreenHeight(10),
  );
  // padding start, top and end
  static EdgeInsetsDirectional paddingSTE = EdgeInsetsDirectional.only(
    start: getProportionateScreenWidth(15),
    top: getProportionateScreenHeight(20),
    end: getProportionateScreenWidth(15),
    bottom: 0.0,
  );
}
