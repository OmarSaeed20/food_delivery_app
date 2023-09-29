import '../../../../index.dart';

class SmallUserCard extends StatelessWidget {
  const SmallUserCard({
    super.key,
    required this.name,
    required this.image,
  });
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(145),
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(20)),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: CircleAvatar(
              radius: getProportionateScreenHeight(90),
              backgroundColor: AppColors.white.withOpacity(0.10),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: getProportionateScreenHeight(400),
              backgroundColor: AppColors.white.withOpacity(0.05),
            ),
          ),
          Container(
            margin: EdgeInsets.all(getProportionateScreenHeight(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: AppColors.offWhite,
                        radius: Dimensions.screenHeight / 14,
                        backgroundImage: NetworkImage(
                          image,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextWidget(
                        text: name,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: getProportionateScreenWidth(20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
