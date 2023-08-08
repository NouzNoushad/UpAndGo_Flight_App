import 'package:flutter/material.dart';

import '../core/colors.dart';

class FlightTextField extends StatelessWidget {
  final String? hintText;
  final String? value;
  final bool enabled;
  final IconData? icon;
  final IconData? suffixIcon;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final void Function()? onIconTap;
  final void Function()? onSuffixIconTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextInputType? keyboardType;
  const FlightTextField(
      {super.key,
      this.hintText,
      this.value,
      this.enabled = true,
      this.icon,
      this.suffixIcon,
      this.onIconTap,
      this.onSuffixIconTap,
      this.focusNode,
      this.controller,
      this.validator,
      this.onSaved,
      this.onTap,
      this.onTapOutside,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder kOutlineInputBorder(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 1.5,
            color: color,
          ),
        );
    return TextFormField(
      style: const TextStyle(
        color: CustomColors.backgroundDark2,
        decorationThickness: 0.0,
      ),
      // initialValue: value,
      enabled: enabled,
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      focusNode: focusNode,
      onTap: onTap,
      onTapOutside: onTapOutside,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: CustomColors.background2,
      decoration: InputDecoration(
        prefixIcon: GestureDetector(
          onTap: onIconTap,
          child: Icon(
            icon,
            size: 18,
            color: CustomColors.background2,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: onSuffixIconTap,
          child: Icon(
            suffixIcon,
            size: 22,
            color: CustomColors.background2,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: CustomColors.backgroundDark2,
        ),
        fillColor: CustomColors.background1,
        filled: true,
        errorStyle: const TextStyle(
          color: CustomColors.background3,
        ),
        enabledBorder: kOutlineInputBorder(CustomColors.background2),
        focusedBorder: kOutlineInputBorder(CustomColors.background2),
        errorBorder: kOutlineInputBorder(CustomColors.background3),
        focusedErrorBorder: kOutlineInputBorder(CustomColors.background3),
      ),
    );
  }
}
