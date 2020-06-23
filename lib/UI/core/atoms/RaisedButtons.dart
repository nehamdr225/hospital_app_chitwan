import 'package:flutter/material.dart';

class FRaisedButton extends StatelessWidget {
  final String text;
  final fontSize;
  final fontWeight;
  final height;
  final width;
  final dynamic onPressed;
  final Color color, bgcolor;
  final shape;
  final needIcon;
  final leadingIcon;
  final trailingIcon;
  final image;
  final imgcolor;
  final elevation;
  final TextAlign textAlign;
  final radius;
  final MainAxisAlignment mainAxisAlignment;
  FRaisedButton({
    this.text,
    this.fontSize: 18.0,
    this.fontWeight,
    this.shape: false,
    this.onPressed,
    this.color,
    this.bgcolor,
    this.width,
    this.height,
    this.elevation,
    this.image,
    this.imgcolor,
    this.needIcon: false,
    this.leadingIcon,
    this.trailingIcon,
    this.radius: 30.0,
    this.textAlign: TextAlign.center,
    this.mainAxisAlignment: MainAxisAlignment.center,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
          elevation: elevation,
          color: bgcolor,
          child: needIcon == true
              ? Row(mainAxisAlignment: mainAxisAlignment, 
              children: [
                  leadingIcon,
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 16.0, color: color, fontWeight: fontWeight),
                  ),
                  trailingIcon
                ])
              : Text(
                text,
                textAlign: textAlign,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: fontSize,
                    color: color,
                    fontWeight: fontWeight),
              ),
          shape: shape == false
              ? Border.all(
                  width: 0.0, color: Theme.of(context).colorScheme.background)
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                ),
          onPressed: onPressed),
    );
  }
}
