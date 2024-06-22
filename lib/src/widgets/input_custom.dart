import 'package:flutter/material.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';

Widget inputCustom(
    {String? hintText,
    String? labelText = '',
    required double fontSize,
    Color backgroundColor = AppColors.$colorBackgroundInput,
    Color color = Colors.black,
    Color colorLabel = Colors.black,
    bool? filled,
    void Function(String)? onChanged,
    InputBorder? border,
    bool rounded = false,
    bool isPassword = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool obscureText = false,
    bool showLabel = true,
    TextInputType? keyboardType,
    TextStyle? hintStyle,
    TextEditingController? controllerInput,
    int? maxLength,
    int? maxLines = 1,
    bool enabled = true,
    String error = '',
    Widget? counter}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Visibility(
        visible: labelText != null && labelText.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 7),
          child: Text(
            '$labelText',
            style: TextStyle(
                fontSize: 20, color: colorLabel, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TextField(
        textCapitalization: TextCapitalization.sentences,
        maxLength: maxLength,
        enabled: enabled,
        maxLines: maxLines,
        keyboardType: isPassword ? TextInputType.visiblePassword : keyboardType,
        obscureText: obscureText,
        controller: controllerInput,
        style: enabled == true
            ? TextStyle(color: color)
            : TextStyle(color: color.withOpacity(0.6)),
        decoration: InputDecoration(
            hintStyle: hintStyle ??
                TextStyle(fontSize: fontSize, color: color.withOpacity(0.6)),
            hintText: hintText,
            fillColor: backgroundColor,
            filled: filled,
            counter: counter,
            counterStyle:
                const TextStyle(color: AppColors.$colorPrimary, fontSize: 16),
            errorText: error.isEmpty ? null : error,
            errorStyle:
                const TextStyle(fontSize: 18, color: AppColors.$colorError),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: AppColors.$colorError)),
            border: rounded
                ? OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
                : border,
            focusedBorder: rounded
                ? OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
                : border,
            prefixIcon: prefixIcon,
            suffixIconColor: AppColors.$colorPrimary.withOpacity(0.7),
            suffixIcon: suffixIcon),
        onChanged: (value) {
          if (onChanged != null) {
            onChanged(value);
          }
        },
      ),
    ],
  );
}
