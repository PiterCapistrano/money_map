import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';
import 'package:money_map/common/constants/widgets/custom_bottom_sheet.dart';
import 'package:money_map/common/constants/widgets/custom_circular_progress.dart';
import 'package:money_map/common/constants/widgets/custom_text_form_field.dart';
import 'package:money_map/common/constants/widgets/multi_text_button.dart';
import 'package:money_map/common/constants/widgets/primary_button.dart';
import 'package:money_map/common/constants/widgets/password_form_field.dart';
import 'package:money_map/common/utils/uppercase_text_formatter.dart';
import 'package:money_map/common/utils/validator.dart';
import 'package:money_map/features/sign_up/sign_up_controller.dart';
import 'package:money_map/features/sign_up/sign_up_state.dart';
import 'package:money_map/services/mock_auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = SignUpController(MockAuthService());

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        if (_controller.state is SignUpLoadingState) {
          showDialog(
              context: context,
              builder: (context) => const CustomCircularProgress());
        }
        if (_controller.state is SignUpSuccessState) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(
                  child: Text("Nova Tela"),
                ),
              ),
            ),
          );
        }
        if (_controller.state is SignUpErrorState) {
          final error = _controller.state as SignUpErrorState;
          Navigator.pop(context);
          customModalBottomSheet(
            context,
            error.message,
            "Tentar novamente",
          );
        }
      },
    );
  }

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
                    textEditingController: _nameController,
                    labelText: "your name",
                    hintText: "NAME",
                    suffixIcon: const Icon(Icons.person),
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [
                      UppercaseTextFormatter(),
                    ],
                    validator: Validator.validateName,
                  ),
                  CustomTextFormField(
                    textEditingController: _emailController,
                    labelText: "your e-mail",
                    hintText: "E-Mail",
                    suffixIcon: const Icon(Icons.email),
                    textInputType: TextInputType.emailAddress,
                    validator: Validator.validateEmail,
                  ),
                  PasswordFormField(
                    textEditingController: _passwordController,
                    labelText: "choose your password",
                    hintText: "********",
                    helperText:
                        "Must have at least 8 characters, 1 capital letter, 1 number and 1 special character.",
                    validator: Validator.validatePassword,
                  ),
                  PasswordFormField(
                      labelText: "confirm your password",
                      hintText: "********",
                      validator: (value) => Validator.validateConfirmPassword(
                          value, _passwordController.text)),
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
                  _controller.signUp(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
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
                    builder: (context) => const SignUp(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
