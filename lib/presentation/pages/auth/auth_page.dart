import '../../../index.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: AppConstants.paddingSTE,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppConstants.kHeightBox20,
                  SvgPicture.asset(
                    Images.logo,
                    height: getProportionateScreenHeight(120),
                    width: getProportionateScreenHeight(120),
                  ),
                  AppConstants.kHeightBox40,
                  Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: Dimensions.screenWidth,
                          height: 1,
                          color: AppColors.primaryColor.withOpacity(0.4),
                        ),
                      ),
                      TabBar(
                        indicatorWeight: 3,
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: controller,
                        labelColor: AppColors.black,
                        indicatorColor: AppColors.primaryColor,
                        unselectedLabelColor: AppColors.grey,
                        tabs: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenWidth(14),
                            ),
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenWidth(14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: const [
                  SignInWidget(),
                  SignUpWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
