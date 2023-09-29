import '../../index.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: getProportionateScreenHeight(20),
        width: getProportionateScreenHeight(20),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.white),
        ),
      ),
    );
  }
}
