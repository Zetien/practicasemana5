import 'package:flutter/material.dart';
import 'package:proyecto_semana_5/theme/theme_colors.dart';

class CustomText extends Text {
  CustomText({
    super.key,
    required this.text,
    this.color = ThemeColors.tertiary,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.decoration = TextDecoration.none,
    super.textAlign,
    super.overflow,
  }) : super(
          text,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
          ),
        );

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextDecoration decoration;
}
