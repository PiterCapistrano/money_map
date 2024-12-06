import 'package:flutter/material.dart';
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

  const CustomTextFormField(
      {super.key,
      this.padding,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.textCapitalization,
      this.textEditingController,
      this.textInputType,
      this.maxLength,
      this.textInputAction});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.lightGreenOne),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: TextFormField(
        cursorColor: AppColors.darkGreen,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        maxLines: 1,
        maxLength: widget.maxLength,
        keyboardType: widget.textInputType,
        controller: widget.textEditingController,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        decoration: InputDecoration(
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
