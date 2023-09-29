import 'package:flutter/cupertino.dart';

import '../../../../index.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Form(
          onChanged: () => controller.onChangedSignUp(),
          child: ListView(padding: AppConstants.paddingSTE * 1.5, children: [
            TextInputWidget(
              title: 'User name',
              controller: controller.name,
              prefixIcon: CupertinoIcons.person_alt,
              validator: (val) =>
                  // isBlank = isEmpty
                  GetUtils.isBlank(controller.name.text) == false
                      ? null
                      : 'The name field is required.',
            ),
            AppConstants.kHeightBox15,
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
            AppConstants.kHeightBox15,
            TextInputWidget(
              title: 'Phone number',
              controller: controller.phone,
              type: TextInputType.phone,
              prefixIcon: CupertinoIcons.phone,
              validator: (val) => GetUtils.isLengthEqualTo(val, 11)
                  ? null
                  : 'The phone field is required.',
            ),
            AppConstants.kHeightBox40,
            Padding(
                padding: AppConstants.paddingSE,
                child: AbsorbPointer(
                    absorbing: controller.isEmptyFeild,
                    child: BtnWidget(
                      title: 'Sign up',
                      fontSize: getProportionateScreenWidth(18),
                      radius: getProportionateScreenHeight(30),
                      height: getProportionateScreenHeight(50),
                      backgroundColor: controller.isEmptyFeild
                          ? AppColors.grey.withOpacity(0.6)
                          : AppColors.primaryColor,
                      isLoading: controller.isLoading,
                      onPressed: () => controller.onTappedSignUp(),
                    )))
          ]));
    });
  }
}
