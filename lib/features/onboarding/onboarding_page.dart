import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      child: Column(
        children: [
          const SizedBox(
            height: 60.0,
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.iceWhite,
              child: Image.asset('assets/images/access_image.png'),
            ),
          ),
          Text(
            'Spend Smarter',
            style: AppTextStyles.mediumText
                .copyWith(color: AppColors.lightGreenTwo),
          ),
          Text(
            'Save More',
            style: AppTextStyles.mediumText
                .copyWith(color: AppColors.lightGreenTwo),
          ),
          Container(
            alignment: Alignment.center,
            width: 358.0,
            height: 64.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.greenGradient,
              ),
            ),
            child: Text(
              'Get Started',
              style:
                  AppTextStyles.mediumText18.copyWith(color: AppColors.white),
            ),
          ),
          Text('Already have account? Log In',
              style:
                  AppTextStyles.smallText.copyWith(color: AppColors.darkGrey)),
          const SizedBox(
            height: 60.0,
          )
        ],
      ),
    ));
  }
}
