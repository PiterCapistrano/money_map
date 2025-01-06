import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';
import 'package:money_map/common/constants/widgets/multi_text_button.dart';
import 'package:money_map/common/constants/widgets/primary_button.dart';
import 'package:money_map/features/login/login.dart';
import 'package:money_map/features/sign_up/sign_up.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.iceWhite,
        body: Align(
          child: Column(
            children: [
              Expanded(
                child: Image.asset('assets/images/access_image.png'),
              ),
              Text(
                'Spend Smarter',
                style: AppTextStyles.mediumText
                    .copyWith(color: AppColors.darkGreen),
              ),
              Text(
                'Save More',
                style: AppTextStyles.mediumText
                    .copyWith(color: AppColors.darkGreen),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 32.0,
                  right: 32.0,
                  top: 16.0,
                  bottom: 4.0,
                ),
                child: PrimaryButton(
                  text: 'Get Started',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ));
                  },
                ),
              ),
              MultiTextButton(
                children: [
                  Text(
                    'Already have account? ',
                    style: AppTextStyles.smallText
                        .copyWith(color: AppColors.darkGrey),
                  ),
                  Text(
                    'Log in',
                    style: AppTextStyles.smallText
                        .copyWith(color: AppColors.darkGreen),
                  )
                ],
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ));
                },
              ),
              const SizedBox(
                height: 24.0,
              )
            ],
          ),
        ));
  }
}
