import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';
import 'package:money_map/common/constants/widgets/custom_text_form_field.dart';
import 'package:money_map/common/constants/widgets/multi_text_button.dart';
import 'package:money_map/common/constants/widgets/primary_button.dart';
import 'package:money_map/common/constants/widgets/password_form_field.dart';
import 'package:money_map/common/utils/validator.dart';
import 'package:money_map/features/sing_up/sing_up_controller.dart';
import 'package:money_map/features/sing_up/sing_up_state.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _controller = SingUpController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        if (_controller.state is SingUpLoadingState) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (_controller.state is SingUpSuccessState) {
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
        if (_controller.state is SingUpErrorState) {
          Navigator.pop(context);
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Erro ao efetuar o Login'),
                      ElevatedButton(
                        child: const Text('Fechar'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
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
                  const CustomTextFormField(
                    labelText: "your name",
                    hintText: "NAME",
                    suffixIcon: Icon(Icons.person),
                    textCapitalization: TextCapitalization.words,
                    /*inputFormatters: [
                      UppercaseTextFormatter(),
                    ],*/
                    validator: Validator.validateName,
                  ),
                  const CustomTextFormField(
                    labelText: "your e-mail",
                    hintText: "E-Mail",
                    suffixIcon: Icon(Icons.email),
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
                  _controller.doSingUp();
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
