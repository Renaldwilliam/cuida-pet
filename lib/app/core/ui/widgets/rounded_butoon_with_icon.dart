// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/size_screen_extension.dart';

class RoundedButoonWithIcon extends StatelessWidget {
  final GestureTapCallback onTap;
  final Color color;
  final double width;
  final String label;
  final IconData icon;
  const RoundedButoonWithIcon({
    Key? key,
    required this.onTap,
    required this.color,
    required this.width,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 45.h,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 2),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20.w,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: VerticalDivider(color: Colors.white, thickness: 2),
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  label,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
