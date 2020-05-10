import 'package:flutter/material.dart';

class  FForms extends StatelessWidget {
  final bool obscure;
  final String text;
  final bool labeltext;
  final icon;
  final trailingIcon;
  final prefix;
  final TextInputType type;
  final Function onChanged;
  final height;
  final width;
  final underline;
  final borderColor;
  final formColor;
  final textColor;
  final style = TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Colors.grey[400]);
  FForms(
      {this.text,
      this.height,
      this.labeltext: true,
      this.width,
      this.type,
      this.obscure: false,
      this.onChanged,
      this.icon,
      this.trailingIcon,
      this.prefix,
      this.underline: false,
      this.formColor: Colors.white,
      this.borderColor: Colors.white,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: formColor,
      child: TextField(
        keyboardType: type,
        autofocus: false,
        obscureText: obscure,
        onChanged: onChanged,
        decoration: InputDecoration(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          prefix: prefix,
          prefixIcon: icon,
          suffixIcon: trailingIcon,
          hintText: labeltext == true ? text : '',
          enabled: true,
          labelStyle: style.copyWith(color: textColor),
          labelText: text,
          hintStyle: style.copyWith(color: textColor),
          enabledBorder: underline == false
              ? OutlineInputBorder(borderSide: BorderSide(color: borderColor))
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primaryVariant,
                )),
          focusedBorder: underline == false
              ? OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary))
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primaryVariant,
                )),
        ),
      ),
    );
  }
}
