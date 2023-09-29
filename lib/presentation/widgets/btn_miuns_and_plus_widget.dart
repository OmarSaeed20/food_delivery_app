import '../../index.dart';

class BtnMiunsAndPlusWidget extends StatelessWidget {
  const BtnMiunsAndPlusWidget({
    Key? key,
    required this.title,
    required this.miunsTapped,
    required this.plusTapped,
    this.iconColor,
    this.backgroundColor,
    this.fontSize,
  }) : super(key: key);
  final String title;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? fontSize;
  final VoidCallback miunsTapped;
  final VoidCallback plusTapped;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconBtnWidget(
            backgroundColor: backgroundColor ?? AppColors.transparent,
            onPressed: miunsTapped,
            icon: Icons.remove,
            color: iconColor,
          ),
          TextWidget(
            text: title,
            fontSize: fontSize,
          ),
          IconBtnWidget(
            backgroundColor: backgroundColor ?? AppColors.transparent,
            onPressed: plusTapped,
            icon: Icons.add,
            color: iconColor,
          ),
        ],
      ),
    );
  }
}
