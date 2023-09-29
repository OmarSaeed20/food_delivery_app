import '../../index.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    this.controller,
    this.type,
    this.title,
    this.isPassword = false,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.val,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType? type;
  final String? title;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? val;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: '$title',
          fontSize: getProportionateScreenWidth(14),
          fontWeight: FontWeight.w600,
        ),
        AppConstants.kHeightBox10,
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: AppConstants.boxShadow,
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: val,
            controller: controller,
            keyboardType: type ?? TextInputType.text,
            obscureText: isPassword,
            cursorColor: AppColors.black,
            style: TextStyle(
              color: AppColors.black,
              fontSize: getProportionateScreenWidth(16),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsetsDirectional.fromSTEB(
                getProportionateScreenWidth(10),
                getProportionateScreenHeight(15),
                0.0,
                getProportionateScreenWidth(15),
              ),
              hintText: title,
              hintStyle: TextStyle(
                color: AppColors.grey.withOpacity(0.6),
                fontSize: getProportionateScreenWidth(14),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.white,
              prefixIcon: prefixIcon != null
                  ? IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        prefixIcon,
                        size: getProportionateScreenHeight(20),
                        color: AppColors.black,
                      ),
                    )
                  : null,
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        suffixIcon,
                        color: AppColors.black,
                      ),
                    )
                  : null,
            ),
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
