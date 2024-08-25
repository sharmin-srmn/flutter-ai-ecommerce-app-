import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'features/authentication/screens/onboarding/onboarding.dart';
import 'bindings/general_bindings.dart';
import 'utils/constants/colors.dart';
import 'utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      //show loader or circular progress indicator meanwhile authenticaTION REPOSITORY is deciding to show relevant screen
      home: const Scaffold(
        backgroundColor: TColors.primaryColor,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
      // home: const OnBoardingScreen(),
      // home: const SplashScreen(),
    );
  }
}
