import 'dart:io';
import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/Widget/InputForm.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/state/doctor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum AppointmentT { opd, online, both }

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  File _image;
  File _profileImg;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _profileImg = File(pickedFile.path);
    });
  }

  Map<String, String> updateData = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    AppointmentT _appointment;
    final doctor = Provider.of<DoctorDataStore>(context).user;

    if (doctor['consultationType'] != null) {
      if (doctor['consultationType'] == 'online')
        _appointment = AppointmentT.online;
      if (doctor['consultationType'] == 'on-site')
        _appointment = AppointmentT.opd;
      else
        _appointment = AppointmentT.both;
    } else {
      _appointment = AppointmentT.both;
    }
    const departments = const ['OPD', 'SURGERY'];
    String selectedDept = doctor != null ? doctor['department'] ?? null : null;
    final doctorDataStore = Provider.of<DoctorDataStore>(context);
    List hospitals = doctorDataStore.hospitals;
    if (hospitals == null) {
      doctorDataStore.getHospitals();
    }

    String selectedHospital = doctor['hospital'] ?? null;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(
            elevation: 0.0,
            backgroundColor: theme.colorScheme.primary,
            color: Colors.white,
            // onPressed: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => HomePageApp()));
            // },
          )),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            alignment: Alignment.topCenter,
            height: 200.0,
            width: size.width,
            color: theme.colorScheme.primary,
            child: CircleAvatar(
              radius: 55.0,
              backgroundColor: theme.colorScheme.primary,
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    //backgroundImage: FileImage(_profileImg),//Image.file(_profileImg),
                    backgroundColor: theme.colorScheme.background,
                    foregroundColor: Colors.white,
                    radius: 54.0,
                    child: _profileImg != null
                        ? Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(_profileImg),
                                    fit: BoxFit.cover)),
                            //child: Image.file(_profileImg)
                          )
                        : Text(
                            doctor['name'].split(' ').reduce((a, b) {
                              return '${a[0]} ${b[0]}';
                            }),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: theme.colorScheme.primary,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700),
                          ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          icon: Icon(Icons.photo_camera, color: blueGrey),
                          onPressed: getProfileImage))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Container(
            //Name
            padding: const EdgeInsets.all(10.0),
            child: InputField(
              title: 'Name',
              value: doctor["name"] ?? '',
              onChanged: (value) {
                setState(() {
                  updateData['name'] = value;
                });
              },
            ),
          ),
          Padding(
            //Email
            padding: const EdgeInsets.all(10.0),
            child: InputField(
                title: 'Email',
                value: doctor["email"] ?? '',
                onChanged: (value) {
                  setState(() {
                    updateData['email'] = value;
                  });
                }),
          ),
          Container(
            //Contact
            padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
            child: InputField(
                title: 'Contact',
                value: doctor['phone'] ?? '',
                onChanged: (value) {
                  setState(() {
                    updateData['phone'] = value;
                  });
                }),
          ),
          Container(
            //Current Address
            padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
            child: InputField(
                title: 'Current Address',
                value: doctor['address'] ?? "",
                onChanged: (value) {
                  setState(() {
                    updateData['address'] = value;
                  });
                }),
          ),
          // Container(
          //   //Working Hospital
          //   padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          //   child: InputField(
          //       title: 'Working Hospital/Clinic',
          //       value: doctor['hospital'] ?? '',
          //       onChanged: (value) {
          //         setState(() {
          //           updateData['hospital'] = value;
          //         });
          //       }),
          // ),
          Container(
            padding: const EdgeInsets.only(top: 10.0, left: 23.0),
            alignment: Alignment.centerLeft,
            child: DropdownButton(
              underline: SizedBox(),
              hint: Container(
                  height: 45.0,
                  width: size.width * 0.83,
                  alignment: Alignment.centerLeft,
                  child: FancyText(
                    text: "Hospital",
                    color: blueGrey,
                    fontWeight: FontWeight.w500,
                  )),
              value: selectedHospital,
              items: hospitals != null
                  ? hospitals.map((value) {
                      return DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 11.0),
                          child: FancyText(
                            text: value['name'],
                            color: blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: value['name'],
                      );
                    }).toList()
                  : selectedHospital != null
                      ? [selectedHospital].map((value) {
                          return DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 11.0),
                              child: FancyText(
                                text: value,
                                color: blueGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: value,
                          );
                        }).toList()
                      : [],
              onChanged: (value) {
                setState(() {
                  updateData['hospital'] = value;
                  selectedHospital = value;
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10.0, left: 23.0),
            alignment: Alignment.centerLeft,
            child: DropdownButton(
              underline: SizedBox(),
              hint: Container(
                  height: 45.0,
                  width: size.width * 0.83,
                  alignment: Alignment.centerLeft,
                  child: FancyText(
                    text: "Department",
                    color: blueGrey,
                    fontWeight: FontWeight.w500,
                  )),
              value: selectedDept,
              items: departments.map((value) {
                return DropdownMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: FancyText(
                      text: value,
                      color: blueGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  updateData['department'] = value;
                  selectedDept = value;
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: InputField(
                title: 'NMC Registration Number',
                value: doctor['registrationNo'] ?? '',
                onChanged: (value) {
                  setState(() {
                    updateData['registrationNo'] = value;
                  });
                }),
          ),
          Padding(
            //Appointment Type
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: FancyText(
                    text: "Consultation Type: ",
                    size: 12.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Radio(
                            value: AppointmentT.opd,
                            activeColor: theme.iconTheme.color,
                            groupValue: _appointment,
                            onChanged: (AppointmentT value) {
                              setState(() {
                                _appointment = value;
                                updateData['consultationType'] = 'on-site';
                              });
                            },
                          ),
                          FancyText(
                            text: "On-Site Only",
                            size: 15.0,
                            color: blueGrey.withOpacity(0.9),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Radio(
                            value: AppointmentT.online,
                            activeColor: theme.iconTheme.color,
                            groupValue: _appointment,
                            onChanged: (AppointmentT value) {
                              setState(() {
                                _appointment = value;
                                updateData['consultationType'] = 'online';
                              });
                            },
                          ),
                          FancyText(
                            text: "Online Only",
                            size: 15.0,
                            color: blueGrey.withOpacity(0.9),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Radio(
                            value: AppointmentT.both,
                            activeColor: theme.iconTheme.color,
                            groupValue: _appointment,
                            onChanged: (AppointmentT value) {
                              setState(() {
                                _appointment = value;
                                updateData['consultationType'] = 'both';
                              });
                            },
                          ),
                          FancyText(
                            text: "Both",
                            size: 15.0,
                            color: blueGrey.withOpacity(0.9),
                          ),
                        ]),
                      ]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FancyText(
                    text: "Upload NMC registration ID: ",
                    size: 12.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 10.0),
                  _image == null
                      ? IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 26.0,
                            color: theme.colorScheme.primary,
                          ),
                          onPressed: getImage,
                        )
                      : Row(
                          children: <Widget>[
                            Stack(children: <Widget>[
                              Container(
                                  height: 80.0,
                                  width: 80.0,
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Image.file(_image)),
                              Container(
                                height: 80.0,
                                width: 80.0,
                                color: Colors.black38,
                              ),
                            ]),
                            IconButton(
                              icon: Icon(
                                Icons.add_a_photo,
                                size: 26.0,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: getImage,
                            )
                          ],
                        )
                ]),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
              alignment: Alignment.center,
              child: FRaisedButton(
                width: size.width * 0.50,
                elevation: 0.0,
                text: "Save Changes",
                bg: theme.colorScheme.primary,
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.w600,
                borderColor: theme.colorScheme.background,
                onPressed: () {
                  print(updateData);
                  if (updateData.length > 0)
                    doctorDataStore
                        .update(updateData)
                        .then((value) => print(value));
                },
              )),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(height: 20.0),
          FRaisedButton(
            text: 'Change Password',
            color: theme.colorScheme.onPrimary,
            bg: theme.colorScheme.background,
            borderColor: theme.colorScheme.background,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            height: 45.0,
            elevation: 0.0,
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ResetPage()));
            },
          ),
          FRaisedButton(
            text: 'Deactivate Account',
            color: theme.colorScheme.onPrimary,
            bg: theme.colorScheme.background,
            borderColor: theme.colorScheme.background,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            height: 45.0,
            elevation: 0.0,
            onPressed: () {
              // Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          ),
          FRaisedButton(
            text: 'Delete Account',
            color: theme.colorScheme.secondary,
            bg: theme.colorScheme.background,
            borderColor: theme.colorScheme.background,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            height: 45.0,
            elevation: 0.0,
            onPressed: () {
              // Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          ),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }
}
