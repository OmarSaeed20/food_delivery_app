import 'dart:async';
import '../../../index.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: 2.seconds)
      ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(3.seconds, () => submitted());
  }

  void submitted() {
    AuthController.to.userLoggedIn()
        ? Get.offNamedUntil(AppRoutes.main, (route) => false)
        : Get.offNamedUntil(AppRoutes.auth, (route) => false);
  }

  /*
        AnyClass(){
          newObject(){
          return ..
        }
      }

      var x = AnyClass()..newObject();
      x = x.newObject();
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: SvgPicture.asset(
                Images.logo,
                height: getProportionateScreenHeight(150),
                width: getProportionateScreenHeight(150),
              ),
            ),
            AppConstants.kHeightBox10,
            Text(
              'The Best Food',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: getProportionateScreenWidth(28),
                fontFamily: 'Horizon',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
