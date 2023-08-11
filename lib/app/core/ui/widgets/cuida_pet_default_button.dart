// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/theme_extension.dart';

class CuidaPetDefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double borderRadius;
  final double? labelSize;
  final double? padding;
  final double? height;
  final double? width;
  final Color? color;
  final Color? labelColor;
  final String label;
  const CuidaPetDefaultButton({
    Key? key,
    required this.onPressed,
    this.borderRadius = 10,
    this.labelSize = 20,
    this.padding = 10,
    this.height = 66,
    this.width = double.infinity,
    this.color,
    this.labelColor,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding!),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            backgroundColor: color ?? context.primaryColor),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            color: labelColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
