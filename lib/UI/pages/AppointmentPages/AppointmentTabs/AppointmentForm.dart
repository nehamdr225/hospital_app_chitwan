import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/models/doctorAppointment.dart';
import 'package:chitwan_hospital/state/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }
enum AppointmentT { opd, online }

class AppointmentForm extends StatefulWidget {
  final DoctorAppointment appointment;
  final doctor;
  final department;
  AppointmentForm(
      {this.doctor, this.department, @required this.appointment, Key key})
      : super(key: key);
  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Gender _gender = Gender.male;
  AppointmentT _appointment = AppointmentT.opd;
  List name = [];
  String _fName;
  String _lName;
  String _fPhone;
  DateTime selectedDate = DateTime.now();
  String _valHospital = "Chitwan Hospital";

  String _valDepartment;
  List _myDepartment = [
    "Operation Theater",
    "ENT",
    "Dermatology",
  ];
  String _valDoctor;
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
    if (widget.department != null) {
      setState(() {
        _valDepartment = widget.department.toString();
        _myDepartment = [widget.department.toString()];
      });
    }
    if (widget.doctor != null) {
      setState(() {
        _valDoctor = widget.doctor.toString();
      });
    }
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
    // print(userDataStore.hospitals);
    List _myHospital = [_valHospital];
    //  userDataStore.hospitals != null
    //     ? userDataStore.hospitals.map<String>((e) => e['name']).toList()
    //     : [];
    // print(_myHospital);
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
            BoolIndicator(isActive),
            SizedBox(
              height: 10.0,
            ),
            Container(
              // first and last name
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  FForms(
                    initialValue: userDataStore.user['name'].split(' ')[0],
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
                    initialValue: userDataStore.user['name'].split(' ')[1],
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
                initialValue: userDataStore.user['phone'],
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
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FancyText(
                      text: "Select Hospital: ",
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
                            width: width * 0.50,
                            alignment: Alignment.center,
                            child: FancyText(
                              text: "Select Hospital",
                              color: blueGrey,
                              fontWeight: FontWeight.w500,
                            )),
                        value: _valHospital,
                        items: _myHospital.map((value) {
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
                            _valHospital = value;
                          });
                        },
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FancyText(
                      text: "Select Department: ",
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
                            width: width * 0.40,
                            alignment: Alignment.center,
                            child: FancyText(
                              text: "Select Department",
                              color: blueGrey,
                              fontWeight: FontWeight.w500,
                            )),
                        value: _valDepartment,
                        // items: userDataStore.hospitals != null &&
                        //         _valHospital != null
                        //     ? userDataStore.hospitals
                        //         .firstWhere((element) =>
                        //             element['name'] ==
                        //             _valHospital)['departments']
                        items: _myDepartment.map((value) {
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
                            _valDepartment = value;
                          });
                        },
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FancyText(
                      text: "Select Doctor: ",
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
                            width: width * 0.50,
                            alignment: Alignment.center,
                            child: FancyText(
                              text: "Select Doctor",
                              color: blueGrey,
                              fontWeight: FontWeight.w500,
                            )),
                        value: _valDoctor,
                        items: _valDoctor != null
                            ? [
                                DropdownMenuItem(
                                  child: FancyText(
                                    text: _valDoctor,
                                    color: blueGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  value: _valDoctor,
                                )
                              ]
                            : _valHospital != null &&
                                    userDataStore.doctors != null
                                ? userDataStore.doctors
                                    // .where((element) =>
                                    //     element['hospital'] == _valHospital)
                                    // .toList()
                                    .map((value) {
                                    return DropdownMenuItem(
                                      child: FancyText(
                                        text: value['name'],
                                        color: blueGrey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      value: value['name'],
                                    );
                                  }).toList()
                                : [
                                    DropdownMenuItem(
                                      child: FancyText(
                                        text: '',
                                        color: blueGrey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      value: '',
                                    )
                                  ],
                        onChanged: (value) {
                          setState(() {
                            _valDoctor = value;
                          });
                        },
                      ),
                    ),
                  ]),
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
                    text: "Consultation Type: ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 10.0),
                  Radio(
                    value: AppointmentT.opd,
                    activeColor: theme.iconTheme.color,
                    groupValue: _appointment,
                    onChanged: (AppointmentT value) {
                      setState(() {
                        _appointment = value;
                      });
                    },
                  ),
                  FancyText(
                    text: "OPD",
                    size: 15.0,
                    color: blueGrey.withOpacity(0.9),
                  ),
                  Radio(
                    value: AppointmentT.online,
                    activeColor: theme.iconTheme.color,
                    groupValue: _appointment,
                    onChanged: (AppointmentT value) {
                      setState(() {
                        _appointment = value;
                      });
                    },
                  ),
                  FancyText(
                    text: "Online",
                    size: 15.0,
                    color: blueGrey.withOpacity(0.9),
                  ),
                ],
              ),
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
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
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
                    widget.appointment.consultationType =
                        _appointment.toString();
                    widget.appointment.doctor = _valDoctor;
                    widget.appointment.department = _valDepartment;
                    widget.appointment.hospital = _valHospital;
                    widget.appointment.date = selectedDate;
                    widget.appointment.time = _valTime;
                    final updateData = widget.appointment.toJson();
                    updateData['userId'] = userDataStore.uid;
                    final doctor = userDataStore.doctors.firstWhere(
                        (element) => element['name'] == _valDoctor,
                        orElse: () => {name: ''});
                    updateData['doctorId'] = doctor['id'];
                    userDataStore.createAppointment(updateData).then((value) {
                      print(value);
                      setState(() {
                        isActive = false;
                      });
                      if (value != 'error') {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
                      }
                    }).catchError((err) {
                      setState(() {
                        isActive = false;
                      });
                      print(err);
                    });
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
