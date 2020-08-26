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
enum BoolEnum { yes, no, unknown }
enum Occupation { student, health_worker, with_animal, lab_worker, others }

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
  Occupation _occupation = Occupation.student;
  BoolEnum _travel = BoolEnum.no;
  BoolEnum _infection = BoolEnum.no;
  BoolEnum _animalMarket = BoolEnum.no;
  String _ftravelCountry, _fprobableList, _exposedLocation;
  List name = [];
  String _fName;
  String _lName;
  String _fPhone, _fEmail, _fDOB, _fTAddress, _fPAddress, _fAge;
  String _fHName, _foccupation, _fLivemarket;
  DateTime selectedDate = DateTime.now();

  bool healthCareSeeting = true;
  bool familySeeting = false;
  bool workPlace = false;
  bool unknown = false;

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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FancyText(
                  textAlign: TextAlign.start,
                  text: "Patient's Information",
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  size: 14.0,
                ),
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
                    Icons.email,
                    color: theme.iconTheme.color,
                  ),
                  text: "Email",
                  type: TextInputType.emailAddress,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) => val.isEmpty || val.length < 8
                      ? 'Email is required'
                      : null,
                  onSaved: (value) {
                    _fEmail = value;
                  },
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
                //gender
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    FancyText(
                      textOverflow: TextOverflow.visible,
                      textAlign: TextAlign.start,
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
                //DOB
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FForms(
                      width: width * 0.60,
                      initialValue: userDataStore.user != null
                          ? userDataStore.user.phone
                          : null,
                      text: "Date of Birth",
                      type: TextInputType.number,
                      labeltext: false,
                      hintText: 'MM-DD-YYYY',
                      //width: width * 0.80,
                      borderColor: theme.colorScheme.primary,
                      formColor: Colors.white,
                      textColor: blueGrey.withOpacity(0.7),
                      validator: (val) => val.isEmpty || val.length < 8
                          ? 'DOB is required'
                          : null,
                      onSaved: (value) {
                        _fDOB = value;
                      },
                    ),
                    FForms(
                      width: width * 0.30,
                      initialValue: userDataStore.user != null
                          ? userDataStore.user.phone
                          : null,
                      text: "Age",
                      type: TextInputType.number,
                      //width: width * 0.80,
                      borderColor: theme.colorScheme.primary,
                      formColor: Colors.white,
                      textColor: blueGrey.withOpacity(0.7),
                      validator: (val) => val.isEmpty || val.length < 8
                          ? 'Age is required'
                          : null,
                      onSaved: (value) {
                        _fAge = value;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                //Temp Address
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  initialValue: userDataStore.user != null
                      ? userDataStore.user.phone
                      : null,
                  labeltext: false,
                  text: "Temporary Address",
                  hintText: "Province, District, Municipality, Ward",
                  type: TextInputType.text,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) => val.isEmpty || val.length < 8
                      ? 'Temporary Address is required'
                      : null,
                  onSaved: (value) {
                    _fTAddress = value;
                  },
                ),
              ),
              Padding(
                //permananet address
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  initialValue: userDataStore.user != null
                      ? userDataStore.user.phone
                      : null,
                  labeltext: false,
                  text: "Permanent Address",
                  hintText: "Province, District, Municipality, Ward",
                  type: TextInputType.text,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) => val.isEmpty || val.length < 8
                      ? 'Permanent Address is required'
                      : null,
                  onSaved: (value) {
                    _fPAddress = value;
                  },
                ),
              ),
              Padding(
                //phone number
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  labeltext: false,
                  text: "Name of hospital",
                  hintText: "Name of hospital where patient is admitted.",
                  type: TextInputType.text,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  onSaved: (value) {
                    _fHName = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FancyText(
                  textAlign: TextAlign.start,
                  text: "Exposure and Travel Information",
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  size: 14.0,
                ),
              ),
              Padding(
                //Occupation
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FancyText(
                      textOverflow: TextOverflow.visible,
                      textAlign: TextAlign.start,
                      text: "Occupation",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 10.0),
                    Row(
                      children: [
                        Radio(
                          value: Occupation.student,
                          activeColor: theme.iconTheme.color,
                          groupValue: _occupation,
                          onChanged: (Occupation value) {
                            setState(() {
                              _occupation = value;
                            });
                          },
                        ),
                        FancyText(
                          text: "Student",
                          size: 15.0,
                          color: blueGrey.withOpacity(0.9),
                        ),
                      ],
                    ),
                    Row(children: [
                      Radio(
                        value: Occupation.health_worker,
                        activeColor: theme.iconTheme.color,
                        groupValue: _occupation,
                        onChanged: (Occupation value) {
                          setState(() {
                            _occupation = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Health Worker",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    Row(children: [
                      Radio(
                        value: Occupation.with_animal,
                        activeColor: theme.iconTheme.color,
                        groupValue: _occupation,
                        onChanged: (Occupation value) {
                          setState(() {
                            _occupation = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Works with animals",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    Row(children: [
                      Radio(
                        value: Occupation.lab_worker,
                        activeColor: theme.iconTheme.color,
                        groupValue: _occupation,
                        onChanged: (Occupation value) {
                          setState(() {
                            _occupation = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Labratory Worker",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    Row(children: [
                      Radio(
                        value: Occupation.others,
                        activeColor: theme.iconTheme.color,
                        groupValue: _occupation,
                        onChanged: (Occupation value) {
                          setState(() {
                            _occupation = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Others",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    _occupation == Occupation.others
                        ? Padding(
                            //phone number
                            padding: const EdgeInsets.all(10.0),
                            child: FForms(
                              initialValue: userDataStore.user != null
                                  ? userDataStore.user.phone
                                  : null,
                              text: "Specify occupation",
                              type: TextInputType.text,
                              //width: width * 0.80,
                              underline: true,
                              borderColor: theme.colorScheme.primary,
                              formColor: Colors.white,
                              textColor: blueGrey.withOpacity(0.7),
                              validator: (val) => val.isEmpty || val.length < 8
                                  ? 'Occupation is required'
                                  : null,
                              onSaved: (value) {
                                _foccupation = value;
                              },
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              Padding(
                // travel
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FancyText(
                      textOverflow: TextOverflow.visible,
                      textAlign: TextAlign.start,
                      text:
                          "Has the patient travelled in the 14 days prior to symptom onset? ",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 10.0),
                    Row(
                      children: [
                        Radio(
                          value: BoolEnum.yes,
                          activeColor: theme.iconTheme.color,
                          groupValue: _travel,
                          onChanged: (BoolEnum value) {
                            setState(() {
                              _travel = value;
                            });
                          },
                        ),
                        FancyText(
                          text: "Yes",
                          size: 15.0,
                          color: blueGrey.withOpacity(0.9),
                        ),
                      ],
                    ),
                    Row(children: [
                      Radio(
                        value: BoolEnum.no,
                        activeColor: theme.iconTheme.color,
                        groupValue: _travel,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            _travel = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "No",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    Row(children: [
                      Radio(
                        value: BoolEnum.unknown,
                        activeColor: theme.iconTheme.color,
                        groupValue: _travel,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            _travel = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Unknown",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    _travel == BoolEnum.yes
                        ? Padding(
                            //phone number
                            padding: const EdgeInsets.all(10.0),
                            child: FForms(
                              initialValue: userDataStore.user != null
                                  ? userDataStore.user.phone
                                  : null,
                              text: "Specify country",
                              type: TextInputType.text,
                              //width: width * 0.80,
                              underline: true,
                              borderColor: theme.colorScheme.primary,
                              formColor: Colors.white,
                              textColor: blueGrey.withOpacity(0.7),
                              validator: (val) => val.isEmpty || val.length < 8
                                  ? 'Country is required'
                                  : null,
                              onSaved: (value) {
                                _ftravelCountry = value;
                              },
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              Padding(
                // travel
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FancyText(
                      textOverflow: TextOverflow.visible,
                      textAlign: TextAlign.start,
                      text:
                          "Has the patient had close contact with a probable or confirmed in the 14 days prior to symptom onset? ",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 10.0),
                    Row(
                      children: [
                        Radio(
                          value: BoolEnum.yes,
                          activeColor: theme.iconTheme.color,
                          groupValue: _infection,
                          onChanged: (BoolEnum value) {
                            setState(() {
                              _infection = value;
                            });
                          },
                        ),
                        FancyText(
                          text: "Yes",
                          size: 15.0,
                          color: blueGrey.withOpacity(0.9),
                        ),
                      ],
                    ),
                    Row(children: [
                      Radio(
                        value: BoolEnum.no,
                        activeColor: theme.iconTheme.color,
                        groupValue: _infection,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            _infection = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "No",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    Row(children: [
                      Radio(
                        value: BoolEnum.unknown,
                        activeColor: theme.iconTheme.color,
                        groupValue: _infection,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            _infection = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Unknown",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    _infection == BoolEnum.yes
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Padding(
                                  //phone number
                                  padding: const EdgeInsets.all(10.0),
                                  child: FForms(
                                    initialValue: userDataStore.user != null
                                        ? userDataStore.user.phone
                                        : null,
                                    text:
                                        "please list all probable or confirmed cases",
                                    type: TextInputType.text,
                                    //width: width * 0.80,
                                    underline: true,
                                    borderColor: theme.colorScheme.primary,
                                    formColor: Colors.white,
                                    textColor: blueGrey.withOpacity(0.7),
                                    validator: (val) =>
                                        val.isEmpty || val.length < 8
                                            ? 'Required'
                                            : null,
                                    onSaved: (value) {
                                      _fprobableList = value;
                                    },
                                  ),
                                ),
                                Padding(
                                  //phone number
                                  padding: const EdgeInsets.all(10.0),
                                  child: FForms(
                                    initialValue: userDataStore.user != null
                                        ? userDataStore.user.phone
                                        : null,
                                    text: "location/city/country for exposure",
                                    type: TextInputType.text,
                                    //width: width * 0.80,
                                    underline: true,
                                    borderColor: theme.colorScheme.primary,
                                    formColor: Colors.white,
                                    textColor: blueGrey.withOpacity(0.7),
                                    validator: (val) =>
                                        val.isEmpty || val.length < 8
                                            ? 'Location is required'
                                            : null,
                                    onSaved: (value) {
                                      _exposedLocation = value;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FancyText(
                                    text:
                                        "Contact seeting(check all that apply): ",
                                    size: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: healthCareSeeting,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            healthCareSeeting = newValue;
                                          });
                                        }),
                                    FancyText(
                                      text: "Health Care Seeting",
                                      size: 15.0,
                                      color: blueGrey.withOpacity(0.9),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: familySeeting,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            familySeeting = newValue;
                                          });
                                        }),
                                    FancyText(
                                      text: "Family Seeting",
                                      size: 15.0,
                                      color: blueGrey.withOpacity(0.9),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: workPlace,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            workPlace = newValue;
                                          });
                                        }),
                                    FancyText(
                                      text: "Work Place",
                                      size: 15.0,
                                      color: blueGrey.withOpacity(0.9),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: healthCareSeeting,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            healthCareSeeting = newValue;
                                          });
                                        }),
                                    FancyText(
                                      text: "Unknown",
                                      size: 15.0,
                                      color: blueGrey.withOpacity(0.9),
                                    ),
                                  ],
                                ),
                              ])
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              Padding(
                // travel
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FancyText(
                      textOverflow: TextOverflow.visible,
                      textAlign: TextAlign.start,
                      text:
                          "Have you visited any live animal markets in the 14 days prior to symptom onset? ",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 10.0),
                    Row(
                      children: [
                        Radio(
                          value: BoolEnum.yes,
                          activeColor: theme.iconTheme.color,
                          groupValue: _animalMarket,
                          onChanged: (BoolEnum value) {
                            setState(() {
                              _animalMarket = value;
                            });
                          },
                        ),
                        FancyText(
                          text: "Yes",
                          size: 15.0,
                          color: blueGrey.withOpacity(0.9),
                        ),
                      ],
                    ),
                    Row(children: [
                      Radio(
                        value: BoolEnum.no,
                        activeColor: theme.iconTheme.color,
                        groupValue: _animalMarket,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            _animalMarket = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "No",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    Row(children: [
                      Radio(
                        value: BoolEnum.unknown,
                        activeColor: theme.iconTheme.color,
                        groupValue: _animalMarket,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            _animalMarket = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Unknown",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    _animalMarket == BoolEnum.yes
                        ? Padding(
                            //phone number
                            padding: const EdgeInsets.all(10.0),
                            child: FForms(
                              initialValue: userDataStore.user != null
                                  ? userDataStore.user.phone
                                  : null,
                              text: "Specify place",
                              type: TextInputType.text,
                              //width: width * 0.80,
                              underline: true,
                              borderColor: theme.colorScheme.primary,
                              formColor: Colors.white,
                              textColor: blueGrey.withOpacity(0.7),
                              validator: (val) => val.isEmpty || val.length < 8
                                  ? 'Country is required'
                                  : null,
                              onSaved: (value) {
                                _fLivemarket = value;
                              },
                            ),
                          )
                        : SizedBox.shrink(),
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
                            if (!_formKey.currentState.validate()) {
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
                            widget.appointment.gender = _gender;
                            widget.appointment.date = selectedDate;
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
