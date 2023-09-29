import '../../index.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
    this.isShow = true,
  });
  final String title;
  final List<Widget>? actions;
  final bool isShow;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isShow,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: AppColors.black),
      backgroundColor: AppColors.white,
      title: TextWidget(
        text: title,
        fontSize: getProportionateScreenWidth(18),
        fontWeight: FontWeight.w600,
      ),
      actions: actions,
    );
  }
}
