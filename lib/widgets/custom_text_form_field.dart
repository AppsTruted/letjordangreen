import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letjordangreen/core/functions/dissmiss_keybooard.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType textInputType;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? textInputFormatter;
  final bool enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String value)? onChange;
  final int? maxLine;
  final InputBorder? border;
  final FocusNode? focusNode;
  final TextStyle? style;
  final TextDirection? textDirection;
  final Color? cursorColor;
  final Color? fillColor;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final bool? readOnly;
  final bool? autofocus;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String? value)? onSave;
  final List<String>? autofillHints;
  final Function(String value)? onSubmitted;

  const CustomTextFormField(
      {super.key,
        this.labelText,
        this.hintText = "",
        this.obscureText = false,
        this.textDirection,
        this.textInputAction,
        this.textInputType = TextInputType.emailAddress,
        this.textEditingController,
        this.fillColor,
        this.textInputFormatter,
        this.autofocus,
        this.enabled = true,
        this.suffixIcon,
        this.prefixIcon,
        this.onChange,
        this.maxLine,
        this.focusNode,
        this.labelStyle,
        this.hintStyle,
        this.autofillHints,
        this.readOnly,
        this.onTap,
        this.maxLength,
        this.border,
        this.cursorColor,
        this.validator,
        this.onSave,
        this.onEditingComplete,
        this.style,
        this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: textInputFormatter,
      controller: textEditingController,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      style: style,
      cursorColor: cursorColor ?? AppColors.primaryColor,
      keyboardAppearance: Brightness.dark,
      focusNode: focusNode,
      autofillHints: autofillHints,
      enabled: enabled,
      maxLength: maxLength,
      onTapOutside: (PointerDownEvent point) {
        unFocusKeyBoard();
      },
      onTap: onTap ?? () {},
      onSaved: onSave,
      onChanged: onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textDirection: textDirection ?? TextDirection.ltr,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      maxLines: maxLine,
      validator: validator,
      onFieldSubmitted: onSubmitted ?? (val){
        unFocusKeyBoard();
      },
      onEditingComplete: onEditingComplete ?? () {},
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        fillColor: fillColor ?? Colors.white,
        focusColor: AppColors.primaryColor,
        filled: true,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
        suffixIcon: suffixIcon,
        //   Padding(
        //   padding: const EdgeInsets.all(15),
        //   child: suffixIcon,
        // ),
        enabledBorder: border ??
            UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
        focusedBorder: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
            ),
        errorBorder: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
            ),
        disabledBorder: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
            ),
        prefixIcon: prefixIcon,
        hintStyle: hintStyle ??
            const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal),
        labelStyle: labelStyle ??
            const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal),
      ),
      obscureText: obscureText,
    );
  }
}
