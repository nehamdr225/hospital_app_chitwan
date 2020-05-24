import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';

class FancyText extends StatelessWidget {
  final String text;
  final double size;
  final fontWeight;
  final Function onTap;
  final TextDecoration decoration;
  final Color decorationColor;
  final Color color;
  final bool defaultStyle;
  final opacity;
  final fontfamily;
  final TextAlign textAlign;

  FancyText(
      {this.text,
      this.color,
      this.fontWeight,
      this.fontfamily: 'Montserrat',
      this.size,
      this.onTap,
      this.opacity: 0.6,
      this.defaultStyle: false,
      this.decoration,
      this.decorationColor: textDark,
      this.textAlign: TextAlign.center});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign,
        style: defaultStyle == true
            ? Theme.of(context).textTheme.body1.copyWith(
                fontSize: size,
                fontWeight: fontWeight,
                color: Theme.of(context)
                    .textTheme
                    .body1
                    .color
                    .withOpacity(opacity))
            : TextStyle(
                fontWeight: fontWeight,
                fontFamily: fontfamily,
                fontSize: size,
                color: color,
                decoration: decoration,
                decorationColor: decorationColor),
      ),
    );
  }
}
