import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/SnackBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/models/PCRAppintment.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }
enum AppointmentT { opd, online }

class PCRAppointmentPage extends StatefulWidget {
  final PCRAppointment appointment;
  final doctor;
  final department;
  PCRAppointmentPage(
      {this.doctor, this.department, @required this.appointment, Key key})
      : super(key: key);
  @override
  _PCRAppointmentPageState createState() => _PCRAppointmentPageState();
}

class _PCRAppointmentPageState extends State<PCRAppointmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Gender _gender = Gender.male;
  List name = [];
  String _fName;
  String _lName;
  String _fPhone;
  DateTime selectedDate = DateTime.now();

  String _valTime;
  List _time = [
    "12:00 PM",
    "5:00 PM",
    "7:00 PM",
  ];
  bool isActive = false;

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
    TextEditingController _textController = new TextEditingController();
    _textController.text = widget.appointment.firstName;
    final theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var style = TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: blueGrey.withOpacity(0.9));

    final userDataStore = Provider.of<UserDataStore>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(41.0),
        child: WhiteAppBar(
          titleColor: theme.colorScheme.primary,
          title: "PCR Appointment Form",
          bottom: PreferredSize(
              child: BoolIndicator(isActive),
              preferredSize: Size.fromHeight(1.0)),
        ),
      ),
      backgroundColor: theme.colorScheme.background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Container(
                // first and last name
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    FForms(
                      initialValue: userDataStore.user != null
                          ? userDataStore.user.name.split(' ')[0]
                          : null,
                      borderColor: theme.colorScheme.primary,
                      formColor: Colors.white,
                      text: "First Name",
                      textColor: blueGrey.withOpacity(0.7),
                      width: width * 0.40,
                      // validator: (val) =>
                      //     val.isEmpty ? 'First Name is required' : null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'First Name is Reqired';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _fName = value;
                      },
                    ),
                    SizedBox(width: 10.0),
                    FForms(
                      initialValue: userDataStore.user != null
                          ? userDataStore.user.name.split(' ')[1]
                          : null,
                      borderColor: theme.colorScheme.primary,
                      formColor: Colors.white,
                      text: "Last Name",
                      type: TextInputType.text,
                      textColor: blueGrey.withOpacity(0.7),
                      width: width * 0.515,
                      validator: (val) =>
                          val.isEmpty ? 'Last Name is required' : null,
                      onSaved: (value) {
                        _lName = value;
                      },
                    )
                  ],
                ),
              ),
              Padding(
                //phone number
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  initialValue: userDataStore.user != null
                      ? userDataStore.user.phone
                      : null,
                  icon: Icon(
                    Icons.phone,
                    color: theme.iconTheme.color,
                  ),
                  text: "Phone Number",
                  type: TextInputType.phone,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) => val.isEmpty || val.length < 8
                      ? 'Phone Number is required'
                      : null,
                  onSaved: (value) {
                    _fPhone = value;
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
                      width: width * 0.50,
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
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FancyText(
                        text: "Pick Time: ",
                        size: 16.0,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        height: 40.0,
                        // width: width * 0.40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: theme.colorScheme.primary,
                            )),
                        child: DropdownButton(
                          underline: SizedBox(),
                          hint: Container(
                              height: 45.0,
                              width: width * 0.45,
                              alignment: Alignment.center,
                              child: FancyText(
                                text: "Pick a time",
                                color: blueGrey,
                                fontWeight: FontWeight.w500,
                              )),
                          value: _valTime,
                          items: _time.map((value) {
                            return DropdownMenuItem(
                              child: FancyText(
                                text: value,
                                color: blueGrey,
                                fontWeight: FontWeight.w500,
                              ),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _valTime = value;
                            });
                          },
                        ),
                      ),
                      Icon(Icons.timer)
                    ]),
              ),
              Padding(
                //gender
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    FancyText(
                      text: "Gender: ",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 10.0),
                    Radio(
                      value: Gender.male,
                      activeColor: theme.iconTheme.color,
                      groupValue: _gender,
                      onChanged: (Gender value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    FancyText(
                      text: "Male",
                      size: 15.0,
                      color: blueGrey.withOpacity(0.9),
                    ),
                    Radio(
                      value: Gender.female,
                      activeColor: theme.iconTheme.color,
                      groupValue: _gender,
                      onChanged: (Gender value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    FancyText(
                      text: "Female",
                      size: 15.0,
                      color: blueGrey.withOpacity(0.9),
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
                    onPressed: isActive
                        ? null
                        : () async {
                            if (userDataStore.user == null) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    promptLoginDialog(context),
                              );
                              return;
                            }
                            if (_valTime == null ||
                                !_formKey.currentState.validate()) {
                              buildAndShowFlushBar(
                                context: context,
                                text: 'Please provide all data!',
                                backgroundColor: theme.colorScheme.error,
                                icon: Icons.error_outline,
                              );
                              return;
                            }
                            setState(() {
                              isActive = true;
                            });
                            _formKey.currentState.save();
                            widget.appointment.firstName = _fName;
                            widget.appointment.lastName = _lName;
                            widget.appointment.phoneNum = _fPhone;
                            widget.appointment.gender = _gender.toString();
                            widget.appointment.date = selectedDate;
                            widget.appointment.time = _valTime;
                            final updateData = widget.appointment.toJson();
                            updateData['userId'] = userDataStore.user.uid;
                            userDataStore
                                .createPCRAppointment(updateData)
                                .then((value) async {
                              setState(() {
                                isActive = false;
                              });
                              if (value != 'error') {
                                buildAndShowFlushBar(
                                  context: context,
                                  text: 'PCR Appointment Created Successfully!',
                                  icon: Icons.check,
                                );
                                await Future.delayed(Duration(seconds: 2));
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (route) => false);
                              } else {
                                buildAndShowFlushBar(
                                  context: context,
                                  text: 'PCR Appointment Creation Failed!',
                                  icon: Icons.error,
                                );
                              }
                            }).catchError((err) {
                              setState(() {
                                isActive = false;
                              });
                              buildAndShowFlushBar(
                                context: context,
                                text: 'Oops something went wrong!',
                                icon: Icons.error,
                              );
                              print(err);
                            });
                          },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
