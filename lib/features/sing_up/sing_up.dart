import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';
import 'package:money_map/common/constants/widgets/custom_text_form_field.dart';
import 'package:money_map/common/constants/widgets/multi_text_button.dart';
import 'package:money_map/common/constants/widgets/primary_button.dart';
import 'package:money_map/common/constants/widgets/pssword_form_field.dart';
import 'package:money_map/common/utils/uppercase_text_formatter.dart';
import 'package:money_map/features/login/login.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final _formKey = GlobalKey<FormState>();

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
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: "your name",
                    hintText: "NAME",
                    suffixIcon: const Icon(Icons.person),
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [
                      UppercaseTextFormatter(),
                    ],
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Esse campo não pode ser vazio";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    labelText: "your e-mail",
                    hintText: "E-Mail",
                    suffixIcon: Icon(Icons.email),
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Esse campo não pode ser vazio";
                      }
                      return null;
                    },
                  ),
                  PasswordFormField(
                    labelText: "your password",
                    hintText: "********",
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Esse campo não pode ser vazio";
                      }
                      return null;
                    },
                  ),
                  PasswordFormField(
                    labelText: "confirm your password",
                    hintText: "********",
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 0.0, bottom: 12.0),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Esse campo não pode ser vazio";
                      }
                      return null;
                    },
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
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  log("Continuar lógica de login");
                } else {
                  log("Erro ao Logar");
                }
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
