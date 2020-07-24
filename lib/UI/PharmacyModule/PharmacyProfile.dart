import 'dart:io';
import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/Widget/InputForm.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/SnackBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/resetPassword.dart';
import 'package:chitwan_hospital/state/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PharmacyProfile extends StatefulWidget {
  @override
  _PharmacyProfileState createState() => _PharmacyProfileState();
}

class _PharmacyProfileState extends State<PharmacyProfile> {
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
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    final pharmacyDataStore = Provider.of<PharmacyDataStore>(context);
    final pharmacy = pharmacyDataStore.user;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(
            elevation: 0.0,
            backgroundColor: theme.colorScheme.primary,
            color: Colors.white,
            bottom: PreferredSize(
              child: BoolIndicator(isActive),
              preferredSize: Size.fromHeight(1),
            ),
          )),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
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
                                  pharmacy != null
                                      ? pharmacy.name.split(' ').reduce((a, b) {
                                          return '${a[0]} ${b[0]}';
                                        })
                                      : '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          color: theme.colorScheme.primary,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w700),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                FRaisedButton(
                  needIcon: true,
                  image: "assets/images/camera.png",
                  imgcolor: textDark_Yellow,
                  text: "Change Photo",
                  color: textDark_Yellow,
                  borderColor: Colors.transparent,
                  bg: theme.colorScheme.primary,
                  elevation: 0.0,
                  width: MediaQuery.of(context).size.width * 0.50,
                  onPressed: getProfileImage,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              //Name
              padding: const EdgeInsets.all(10.0),
              child: InputField(
                title: 'Name',
                value: pharmacy != null ? pharmacy.name ?? '' : '',
                onChanged: (value) => setState(() {
                  updateData = {...updateData, 'name': value};
                }),
              ),
            ),
            Padding(
              //Email
              padding: const EdgeInsets.all(10.0),
              child: InputField(
                title: 'Email',
                value: pharmacy != null ? pharmacy.email ?? '' : '',
              ),
            ),
            Container(
              //Contact
              padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: InputField(
                  title: 'Contact',
                  value: pharmacy != null ? pharmacy.phone ?? '' : '',
                  onChanged: (value) => setState(() {
                        updateData = {...updateData, 'phone': value};
                      })),
            ),
            Container(
              //Current Address
              padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: InputField(
                  title: 'Current Address',
                  value: pharmacy != null ? pharmacy.address ?? '' : '',
                  onChanged: (value) => setState(() {
                        updateData = {...updateData, 'address': value};
                      })),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: InputField(
                  title: 'Pharmacy Registration Number',
                  value: pharmacy != null ? pharmacy.registrationNo ?? '' : '',
                  onChanged: (value) => setState(() {
                        updateData = {...updateData, 'registrationNo': value};
                      })),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: InputField(
                  title: 'Open Hours',
                  value: pharmacy != null ? pharmacy.openHours ?? '' : '',
                  onChanged: (value) => setState(() {
                        updateData = {...updateData, 'openHours': value};
                      })),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FancyText(
                      text: "Upload Pharmacy registration ID: ",
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
                  onPressed: () async {
                    if (updateData.length > 0) {
                      setState(() {
                        isActive = true;
                      });
                      final result = await pharmacyDataStore.update(updateData);
                      setState(() {
                        isActive = false;
                        updateData = {};
                      });
                      if (result) {
                        buildAndShowFlushBar(
                          context: context,
                          icon: Icons.check,
                          text: 'Profile has been updated!',
                        );
                      }
                    }
                  },
                )),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(height: 20.0),
            FRaisedButton(
              text: 'Reset Password',
              color: theme.colorScheme.onPrimary,
              bg: theme.colorScheme.background,
              borderColor: theme.colorScheme.background,
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              height: 45.0,
              elevation: 0.0,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPassword(
                              email: pharmacy != null ? pharmacy.email : null,
                              signout: pharmacyDataStore.clearState,
                            )));
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
      ),
    );
  }
}
