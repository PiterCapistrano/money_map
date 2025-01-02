import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_map/common/constants/app_colors.dart';
import 'package:money_map/common/constants/app_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final String? helperText;

  const CustomTextFormField({
    super.key,
    this.padding,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.textCapitalization,
    this.textEditingController,
    this.textInputType,
    this.maxLength,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.obscureText,
    this.helperText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.lightGreenOne),
  );

  String? _helperText;

  @override
  void initState() {
    super.initState();
    _helperText = widget.helperText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            setState(() {
              _helperText = null;
            });
          } else if (value.isEmpty) {
            setState(() {
              _helperText = widget.helperText;
            });
          }
        },
        validator: widget.validator,
        style: AppTextStyles.inputText.copyWith(color: AppColors.lightGreenOne),
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText ?? false,
        cursorColor: AppColors.darkGreen,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        maxLines: 1,
        maxLength: widget.maxLength,
        keyboardType: widget.textInputType,
        controller: widget.textEditingController,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        decoration: InputDecoration(
            helperText: _helperText,
            helperMaxLines: 3,
            suffixIcon: widget.suffixIcon,
            suffixIconColor: AppColors.grey,
            hintText: widget.hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.labelText?.toUpperCase(),
            labelStyle:
                AppTextStyles.inputLabelText.copyWith(color: AppColors.grey),
            border: defaultBorder,
            focusedBorder: defaultBorder.copyWith(
                borderSide: const BorderSide(color: AppColors.darkGreen)),
            errorBorder: defaultBorder.copyWith(
                borderSide: const BorderSide(color: AppColors.red)),
            focusedErrorBorder: defaultBorder.copyWith(
                borderSide: const BorderSide(color: AppColors.red)),
            enabledBorder: defaultBorder,
            disabledBorder: defaultBorder.copyWith(
                borderSide: const BorderSide(color: AppColors.darkGrey))),
      ),
    );
  }
}
