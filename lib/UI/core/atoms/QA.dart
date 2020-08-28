import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:flutter/material.dart';

class QA extends StatelessWidget {
  final String title;
  final String caption;
  final Color capColor;
  final Color titleColor;
  final bool defaultStyle;
  final FontWeight fontWeight;
  final FontWeight titleWeight;
  final titleSize;
  final capSize;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  QA(
      {this.caption,
      this.title,
      this.titleColor,
      this.capColor,
      this.fontWeight: FontWeight.w500,
      this.defaultStyle: true,
      this.titleSize,
      this.capSize,
      this.titleWeight,
      this.crossAxisAlignment: CrossAxisAlignment.start,
      this.mainAxisAlignment: MainAxisAlignment.start,});
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: FancyText(
            textOverflow: TextOverflow.visible,
            text: title,
            textAlign: TextAlign.left,
            defaultStyle: defaultStyle,
            fontWeight: titleWeight,
            size: titleSize,
            color: titleColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: FancyText(
            textOverflow: TextOverflow.visible,
              text: caption,
              textAlign: TextAlign.left,
              color: capColor,
              size: capSize,
              fontWeight: fontWeight),
        ),
      ],
    );
  }
}
