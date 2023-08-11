// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/theme_extension.dart';

class CuidaPetTextFormField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  CuidaPetTextFormField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.validator,
  }) : _obscureTextVN = ValueNotifier<bool>(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureTextValue,
          decoration: InputDecoration(
            labelStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            suffixIcon: obscureText
                ? IconButton(
                    onPressed: () {
                      _obscureTextVN.value = !obscureTextValue;
                    },
                    icon: Icon(obscureTextValue ? Icons.lock : Icons.lock_open,
                        color: context.primaryColor),
                  )
                : null,
          ),
        );
      },
    );
  }
}
