import 'package:flutter/material.dart';
import 'package:money_map/common/themes/default_theme.dart';
import 'package:money_map/features/onboarding/onboarding_page.dart';
import 'package:money_map/features/sign_up/sign_up.dart';
import 'package:money_map/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme,
      initialRoute: "/splash",
      routes: {
        "/": (context) => const OnboardingPage(),
        "splash": (context) => const SplashPage(),
        "sign_up": (context) => const SignUp(),
      },
    );
  }
}
