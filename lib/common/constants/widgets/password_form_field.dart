import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/widgets/custom_text_form_field.dart';

class PasswordFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? textEditingController;
  final EdgeInsetsGeometry? padding;
  final FormFieldValidator<String>? validator;
  final String? helperText;

  const PasswordFormField({
    super.key,
    this.padding,
    this.hintText,
    this.labelText,
    this.textEditingController,
    this.validator,
    this.helperText,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  final defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.lightGreenOne),
  );

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        textEditingController: widget.textEditingController,
        validator: widget.validator,
        obscureText: isHidden,
        padding: widget.padding,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: InkWell(
          child: Icon(isHidden ? Icons.visibility : Icons.visibility_off),
          onTap: () {
            setState(() {
              isHidden = !isHidden;
            });
          },
        ));
  }
}
