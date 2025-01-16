import 'package:flutter/material.dart';
import 'package:money_map/common/constants/routes.dart';
import 'package:money_map/common/themes/default_theme.dart';
import 'package:money_map/features/home/home_page.dart';
import 'package:money_map/features/onboarding/onboarding_page.dart';
import 'package:money_map/features/sign_in/sign_in.dart';
import 'package:money_map/features/sign_up/sign_up.dart';
import 'package:money_map/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme,
      initialRoute: NamedRoute.splash,
      routes: {
        NamedRoute.initial: (context) => const OnboardingPage(),
        NamedRoute.splash: (context) => const SplashPage(),
        NamedRoute.signUp: (context) => const SignUp(),
        NamedRoute.signIn: (context) => const SignIn(),
        NamedRoute.home: (context) => const HomePage(),
      },
    );
  }
}
