import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: 'OpenSans',
        colorScheme: const ColorScheme.highContrastDark(
          primary: AppColors.primaryColor,
          secondary: AppColors.offWhite,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0.0,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.black.withOpacity(0.4),
          backgroundColor: AppColors.offWhite,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: AppPages.welcome,
      getPages: AppPages.routes,
    );
  }
}
// php artisan serve --host 127.0.0.1 --port 8000
// https://www.flaticon.com/free-icon/warning_4807398