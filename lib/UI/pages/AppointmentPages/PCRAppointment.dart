import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/SnackBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/models/PCRAppintment.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }
enum BoolEnum { yes, no, unknown }
enum Occupation { student, health_worker, with_animal, lab_worker, others }

class PCRAppointmentPage extends StatefulWidget {
  PCRAppointmentPage({Key key}) : super(key: key);
  @override
  _PCRAppointmentPageState createState() => _PCRAppointmentPageState();
}

class _PCRAppointmentPageState extends State<PCRAppointmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PCRAppointment appointment = PCRAppointment(
    closeContactToProbable: BoolEnum.yes,
    gender: Gender.male,
    closeContactDetails: CloseContactDetails(),
    contactSeeting: ContactSeeting(
      workPlace: true,
      healthCare: false,
      family: true,
      unknown: false,
    ),
    liveMarketVisit: BoolEnum.yes,
    occupation: Occupation.others,
    previousTravel: BoolEnum.yes,
  );

  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;

    final userDataStore = Provider.of<UserDataStore>(context);
    if (appointment.firstName == null && appointment.lastName == null) {
      setState(() {
        appointment.firstName = userDataStore.user.name.split(' ')[0];
        appointment.lastName = userDataStore.user.name.split(' ')[1];
        appointment.email = userDataStore.user.email;
        appointment.phoneNum = userDataStore.user.phone;
      });
    }

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
                      initialValue: appointment.firstName,
                      borderColor: theme.colorScheme.primary,
                      formColor: Colors.white,
                      text: "First Name",
                      textColor: blueGrey.withOpacity(0.7),
                      width: width * 0.40,
                      // validator: (val) =>
                      //     val.isEmpty ? 'First Name is required' : null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'First Name is Required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          appointment.firstName = value;
                        });
                      },
                    ),
                    SizedBox(width: 10.0),
                    FForms(
                      initialValue: appointment.lastName,
                      borderColor: theme.colorScheme.primary,
                      formColor: Colors.white,
                      text: "Last Name",
                      type: TextInputType.text,
                      textColor: blueGrey.withOpacity(0.7),
                      width: width * 0.515,
                      validator: (val) =>
                          val.isEmpty ? 'Last Name is required' : null,
                      onChanged: (value) {
                        setState(() {
                          appointment.lastName = value;
                        });
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
                      ? userDataStore.user.email
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
                  validator: (val) => val.isEmpty ? 'Email is required' : null,
                  onChanged: (value) {
                    setState(() {
                      appointment.email = value;
                    });
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
                  onChanged: (value) {
                    setState(() {
                      appointment.phoneNum = value;
                    });
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
                      groupValue: appointment.gender,
                      onChanged: (Gender value) {
                        setState(() {
                          appointment.gender = value;
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
                      groupValue: appointment.gender,
                      onChanged: (Gender value) {
                        setState(() {
                          appointment.gender = value;
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
                      initialValue: appointment.dob,
                      text: "Date of Birth",
                      type: TextInputType.number,
                      labeltext: false,
                      hintText: 'MM-DD-YYYY',
                      //width: width * 0.80,
                      borderColor: theme.colorScheme.primary,
                      formColor: Colors.white,
                      textColor: blueGrey.withOpacity(0.7),
                      validator: (val) =>
                          val.isEmpty ? 'DOB is required' : null,
                      onChanged: (value) {
                        setState(() {
                          appointment.dob = value;
                        });
                      },
                    ),
                    FForms(
                      width: width * 0.30,
                      initialValue: appointment.age,
                      text: "Age",
                      type: TextInputType.number,
                      //width: width * 0.80,
                      borderColor: theme.colorScheme.primary,
                      formColor: Colors.white,
                      textColor: blueGrey.withOpacity(0.7),
                      validator: (val) =>
                          val.isEmpty ? 'Age is required' : null,
                      onChanged: (value) {
                        setState(() {
                          appointment.age = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                //Temp Address
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  initialValue: appointment.temporaryAddress,
                  labeltext: false,
                  text: "Temporary Address",
                  hintText: "Province, District, Municipality, Ward",
                  type: TextInputType.text,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) =>
                      val.isEmpty ? 'Temporary Address is required' : null,
                  onChanged: (value) {
                    setState(() {
                      appointment.temporaryAddress = value;
                    });
                  },
                ),
              ),
              Padding(
                //permananet address
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  initialValue: appointment.permanentAddress,
                  labeltext: false,
                  text: "Permanent Address",
                  hintText: "Province, District, Municipality, Ward",
                  type: TextInputType.text,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) =>
                      val.isEmpty ? 'Permanent Address is required' : null,
                  onChanged: (value) {
                    setState(() {
                      appointment.permanentAddress = value;
                    });
                  },
                ),
              ),
              Padding(
                //phone number
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  labeltext: false,
                  text: "Name of admitted hospital",
                  hintText: "Name of hospital where patient is admitted.",
                  type: TextInputType.text,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  initialValue: appointment.admittedHospital,
                  onChanged: (value) {
                    setState(() {
                      appointment.admittedHospital = value;
                    });
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
                          groupValue: appointment.occupation,
                          onChanged: (Occupation value) {
                            setState(() {
                              appointment.occupation = value;
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
                        groupValue: appointment.occupation,
                        onChanged: (Occupation value) {
                          setState(() {
                            appointment.occupation = value;
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
                        groupValue: appointment.occupation,
                        onChanged: (Occupation value) {
                          setState(() {
                            appointment.occupation = value;
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
                        groupValue: appointment.occupation,
                        onChanged: (Occupation value) {
                          setState(() {
                            appointment.occupation = value;
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
                        groupValue: appointment.occupation,
                        onChanged: (Occupation value) {
                          setState(() {
                            appointment.occupation = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Others",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    appointment.occupation == Occupation.others
                        ? Padding(
                            //phone number
                            padding: const EdgeInsets.all(10.0),
                            child: FForms(
                              initialValue: appointment.otherOccupation,
                              text: "Specify occupation",
                              type: TextInputType.text,
                              //width: width * 0.80,
                              underline: true,
                              borderColor: theme.colorScheme.primary,
                              formColor: Colors.white,
                              textColor: blueGrey.withOpacity(0.7),
                              validator: (val) =>
                                  val.isEmpty ? 'Occupation is required' : null,
                              onChanged: (value) {
                                appointment.otherOccupation = value;
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
                          groupValue: appointment.previousTravel,
                          onChanged: (BoolEnum value) {
                            setState(() {
                              appointment.previousTravel = value;
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
                        groupValue: appointment.previousTravel,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            appointment.previousTravel = value;
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
                        groupValue: appointment.previousTravel,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            appointment.previousTravel = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Unknown",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    appointment.previousTravel == BoolEnum.yes
                        ? Padding(
                            //phone number
                            padding: const EdgeInsets.all(10.0),
                            child: FForms(
                              initialValue: appointment.placeOfTravel,
                              text: "Specify travel location",
                              type: TextInputType.text,
                              //width: width * 0.80,
                              underline: true,
                              borderColor: theme.colorScheme.primary,
                              formColor: Colors.white,
                              textColor: blueGrey.withOpacity(0.7),
                              validator: (val) => val.isEmpty
                                  ? 'Travel location is required'
                                  : null,
                              onChanged: (value) {
                                appointment.placeOfTravel = value;
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
                          groupValue: appointment.closeContactToProbable,
                          onChanged: (BoolEnum value) {
                            setState(() {
                              appointment.closeContactToProbable = value;
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
                        groupValue: appointment.closeContactToProbable,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            appointment.closeContactToProbable = value;
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
                        groupValue: appointment.closeContactToProbable,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            appointment.closeContactToProbable = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Unknown",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    appointment.closeContactToProbable == BoolEnum.yes
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Padding(
                                  //phone number
                                  padding: const EdgeInsets.all(10.0),
                                  child: FForms(
                                    initialValue: appointment
                                        .closeContactDetails?.probableCases,
                                    text:
                                        "please list all probable or confirmed cases",
                                    type: TextInputType.text,
                                    //width: width * 0.80,
                                    underline: true,
                                    borderColor: theme.colorScheme.primary,
                                    formColor: Colors.white,
                                    textColor: blueGrey.withOpacity(0.7),
                                    validator: (val) =>
                                        val.isEmpty ? 'Required' : null,
                                    onChanged: (value) {
                                      setState(() {
                                        appointment.closeContactDetails
                                            .probableCases = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  //phone number
                                  padding: const EdgeInsets.all(10.0),
                                  child: FForms(
                                    initialValue: appointment
                                        .closeContactDetails?.exposedLocation,
                                    text: "location/city/country for exposure",
                                    type: TextInputType.text,
                                    //width: width * 0.80,
                                    underline: true,
                                    borderColor: theme.colorScheme.primary,
                                    formColor: Colors.white,
                                    textColor: blueGrey.withOpacity(0.7),
                                    validator: (val) => val.isEmpty
                                        ? 'Location is required'
                                        : null,
                                    onChanged: (value) {
                                      setState(() {
                                        appointment.closeContactDetails
                                            .exposedLocation = value;
                                      });
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
                                        value: appointment
                                            .contactSeeting.healthCare,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            appointment.contactSeeting
                                                .healthCare = newValue;
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
                                        value:
                                            appointment.contactSeeting.family,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            appointment.contactSeeting.family =
                                                newValue;
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
                                        value: appointment
                                            .contactSeeting.workPlace,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            appointment.contactSeeting
                                                .workPlace = newValue;
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
                                        value:
                                            appointment.contactSeeting.unknown,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            appointment.contactSeeting.unknown =
                                                newValue;
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
                          groupValue: appointment.liveMarketVisit,
                          onChanged: (BoolEnum value) {
                            setState(() {
                              appointment.liveMarketVisit = value;
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
                        groupValue: appointment.liveMarketVisit,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            appointment.liveMarketVisit = value;
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
                        groupValue: appointment.liveMarketVisit,
                        onChanged: (BoolEnum value) {
                          setState(() {
                            appointment.liveMarketVisit = value;
                          });
                        },
                      ),
                      FancyText(
                        text: "Unknown",
                        size: 15.0,
                        color: blueGrey.withOpacity(0.9),
                      ),
                    ]),
                    appointment.liveMarketVisit == BoolEnum.yes
                        ? Padding(
                            //phone number
                            padding: const EdgeInsets.all(10.0),
                            child: FForms(
                              initialValue: appointment.liveMarketLocation,
                              text: "Specify market place",
                              type: TextInputType.text,
                              //width: width * 0.80,
                              underline: true,
                              borderColor: theme.colorScheme.primary,
                              formColor: Colors.white,
                              textColor: blueGrey.withOpacity(0.7),
                              validator: (val) => val.isEmpty || val.length < 8
                                  ? 'Market place is required'
                                  : null,
                              onChanged: (value) {
                                appointment.liveMarketLocation = value;
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
                            _formKey.currentState.save();
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

                            appointment.timestamp = Timestamp.now();
                            appointment.userId = userDataStore.user.uid;
                            final Map updateData = appointment.toJson();
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
