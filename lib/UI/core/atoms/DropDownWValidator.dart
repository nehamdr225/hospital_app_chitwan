import 'package:flutter/material.dart';

class DropDownWValidator extends StatefulWidget {
  final String labelText;
  final Widget hintText;
  final List<String> item ;
  final Function validator;
  final Function onSaved;
  DropDownWValidator({this.hintText, this.item, this.labelText, this.validator, this.onSaved});


  @override
  _DropDownWValidatorState createState() => _DropDownWValidatorState();
}

class _DropDownWValidatorState extends State<DropDownWValidator> {
  String _town; 
  String formData;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      onSaved: widget.onSaved,
      // (value) {
      //   formData = value;
      // },
      builder: (
        FormFieldState<String> state,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new InputDecorator(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                labelText: "widget.labelText",
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: widget.hintText,
                  value: _town,
                  onChanged: (String newValue) {
                    state.didChange(newValue);
                    setState(() {
                      _town = newValue;
                    });
                  },
                  items: widget.item.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              state.hasError ? state.errorText : '',
              style:
                  TextStyle(color: Colors.redAccent.shade700, fontSize: 12.0),
            ),
          ],
        );
      },
    );
  
  }
}