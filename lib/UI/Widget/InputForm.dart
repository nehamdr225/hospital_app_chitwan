import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String value, title;
  final Function onChanged;
  final int maxLines, minLines;
  InputField({
    Key key,
    this.value,
    this.title,
    this.onChanged,
    this.maxLines = 1,
    this.minLines = 1,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      // obscureText: true,
      onChanged: widget.onChanged,
      cursorColor: blueGrey,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide.none),
        labelText: widget.title,
        labelStyle: TextStyle(color: blueGrey),
      ),
    );
  }
}
