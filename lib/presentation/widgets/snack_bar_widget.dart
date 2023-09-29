import '../../index.dart';

SnackbarController snackBarWidget({
  required String title,
  required String msg,
}) =>
    Get.snackbar(
      title,
      msg,
      messageText: TextWidget(
        text: msg,
        color: AppColors.white,
        fontSize: getProportionateScreenWidth(16),
      ),
      backgroundColor: AppColors.primaryColor,
      borderRadius: 4,
    );
