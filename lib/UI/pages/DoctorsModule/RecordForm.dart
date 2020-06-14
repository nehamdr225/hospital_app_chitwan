import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordForm extends StatefulWidget {
  final doctor;
  final department;
  RecordForm({this.doctor, this.department, Key key}) : super(key: key);
  @override
  _RecordFormState createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  String _medicine;
  String _investigation;
  String _diagnosisTitle;
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2020, 9),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController _textController = new TextEditingController();
    //_textController.text = widget.appointment.firstName;
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var style = TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: blueGrey.withOpacity(0.9));

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(
              titleColor: theme.colorScheme.primary,
              title: "Appointment Form")),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Padding(
              //Diagnosis Title
              padding: const EdgeInsets.all(10.0),
              child: FForms(
                text: "Diagnosis Title",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) =>
                    val.isEmpty || val.length < 15 ? 'Diagnosis Title' : null,
                onSaved: (value) {
                  _diagnosisTitle = value;
                },
              ),
            ),
            Padding(
              //Medicine
              padding: const EdgeInsets.all(10.0),
              child: FForms(
                text: "Medicine",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) =>
                    val.isEmpty || val.length < 15 ? 'Medicine' : null,
                onSaved: (value) {
                  _medicine = value;
                },
              ),
            ),
            Padding(
              //Investigation
              padding: const EdgeInsets.all(10.0),
              child: FForms(
                text: "Investigation",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) =>
                    val.isEmpty || val.length > 15 ? 'Investigation' : null,
                onSaved: (value) {
                  _investigation = value;
                },
              ),
            ),
            Padding(
              //date
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FancyText(
                    text: "Pick a date: ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    height: 40.0,
                    width: size.width * 0.50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: theme.colorScheme.primary,
                        )),
                    child: Center(
                      child: Text(
                        "${selectedDate.day.toString()}-${selectedDate.month.toString()}-${selectedDate.year.toString()}",
                        style: style,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 45.0,
                child: RaisedButton(
                  color: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  child: FancyText(
                    text: "SUBMIT",
                    size: 16.0,
                    color: textDark_Yellow,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    // widget.appointment.firstName = _fName;
                    // widget.appointment.lastName = _lName;
                    // widget.appointment.phoneNum = _fPhone;

                    // final uid =
                    //     await Provider.of<AuthService>(context).getCurrentUID();
                    // await db
                    //     .collection("users")
                    //     .document(uid)
                    //     .collection("appointments")
                    //     .add(widget.appointment.toJson());

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
