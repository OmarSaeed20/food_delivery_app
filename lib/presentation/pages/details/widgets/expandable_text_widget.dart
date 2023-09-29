import 'package:flutter/cupertino.dart';
import '../../../../index.dart';

class ExpandableTextWidget extends StatefulWidget {
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  String? text;
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double heightText = Dimensions.screenHeight / 9.14;
  @override
  void initState() {
    if (widget.text.length > heightText) {
      firstHalf = widget.text.substring(0, heightText.toInt());
      secondHalf =
          widget.text.substring(heightText.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: secondHalf.isEmpty
            ? TextWidget(
                text: firstHalf,
                color: AppColors.grey.withOpacity(0.70),
                fontSize: getProportionateScreenWidth(17.0),
              )
            : Column(
                children: [
                  TextWidget(
                    text: hiddenText
                        ? ('$firstHalf ...')
                        : (firstHalf + secondHalf),
                    color: AppColors.grey.withOpacity(0.70),
                    overFlow: TextOverflow.clip,
                    fontSize: getProportionateScreenWidth(17.0),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => hiddenText = !hiddenText),
                    child: Row(
                      children: [
                        TextWidget(
                          text: hiddenText ? 'Show more' : 'Show less',
                          color: AppColors.primaryColor,
                        ),
                        AppConstants.kWidthBox5,
                        Icon(
                          hiddenText
                              ? CupertinoIcons.chevron_down
                              : CupertinoIcons.chevron_up,
                          color: AppColors.primaryColor,
                          size: getProportionateScreenHeight(16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
