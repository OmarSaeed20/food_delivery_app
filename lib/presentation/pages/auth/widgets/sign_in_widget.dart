import 'package:flutter/cupertino.dart';
import '../../../../index.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Form(
          onChanged: () => controller.onChangedSignIn(),
          child: ListView(
            padding: AppConstants.paddingSTE * 1.5,
            children: [
              TextInputWidget(
                title: 'E-mail address',
                controller: controller.email,
                type: TextInputType.emailAddress,
                prefixIcon: CupertinoIcons.mail,
                validator: (val) =>
                    GetUtils.isEmail('$val') ? null : 'The email is not valid.',
              ),
              AppConstants.kHeightBox15,
              TextInputWidget(
                title: 'Password',
                controller: controller.password,
                type: TextInputType.visiblePassword,
                prefixIcon: CupertinoIcons.lock,
                suffixIcon: controller.suffixIcon,
                isPassword: controller.isPassword,
                onPressed: controller.hiddenPassword,
                validator: (val) => GetUtils.isLengthGreaterThan(val, 6)
                    ? null
                    : 'The password field is required.',
              ),
              AppConstants.kHeightBox40,
              Padding(
                padding: AppConstants.paddingSE,
                child: AbsorbPointer(
                  absorbing: controller.isEmptyFeild,
                  child: BtnWidget(
                    title: 'Sign in',
                    fontSize: getProportionateScreenWidth(18),
                    radius: getProportionateScreenHeight(30),
                    height: getProportionateScreenHeight(50),
                    backgroundColor: controller.isEmptyFeild
                        ? AppColors.grey.withOpacity(0.6)
                        : AppColors.primaryColor,
                    isLoading: controller.isLoading,
                    onPressed: () => controller.onTappedSignIn(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
