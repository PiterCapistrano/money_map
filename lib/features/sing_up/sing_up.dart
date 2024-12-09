import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';
import 'package:money_map/common/constants/widgets/custom_text_form_field.dart';
import 'package:money_map/common/constants/widgets/multi_text_button.dart';
import 'package:money_map/common/constants/widgets/primary_button.dart';
import 'package:money_map/common/constants/widgets/pssword_form_field.dart';
import 'package:money_map/features/login/login.dart';

class SingUp extends StatelessWidget {
  const SingUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text(
            'Spend Smarter',
            textAlign: TextAlign.center,
            style:
                AppTextStyles.mediumText.copyWith(color: AppColors.darkGreen),
          ),
          Text(
            'Save More',
            textAlign: TextAlign.center,
            style:
                AppTextStyles.mediumText.copyWith(color: AppColors.darkGreen),
          ),
          Image.asset(
            'assets/images/sing_up.png',
          ),
          const Form(
              child: Column(
            children: [
              CustomTextFormField(
                labelText: "your name",
                hintText: "Name",
                suffixIcon: Icon(Icons.person),
                textCapitalization: TextCapitalization.words,
              ),
              CustomTextFormField(
                labelText: "your e-mail",
                hintText: "E-Mail",
                suffixIcon: Icon(Icons.email),
                textInputType: TextInputType.emailAddress,
              ),
              PasswordFormField(
                labelText: "your password",
                hintText: "********",
                suffixIcon: Icon(Icons.visibility),
                textInputType: TextInputType.visiblePassword,
                maxLength: 12,
              ),
              PasswordFormField(
                labelText: "confirm your password",
                hintText: "********",
                suffixIcon: Icon(Icons.visibility),
                textInputType: TextInputType.visiblePassword,
                maxLength: 12,
                textInputAction: TextInputAction.done,
                padding: EdgeInsets.only(
                    left: 24.0, right: 24.0, top: 0.0, bottom: 12.0),
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 16.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              text: 'Sing Up',
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
                style:
                    AppTextStyles.smallText.copyWith(color: AppColors.darkGrey),
              ),
              Text(
                'Sing in',
                style: AppTextStyles.smallText
                    .copyWith(color: AppColors.darkGreen),
              )
            ],
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SingUp(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
