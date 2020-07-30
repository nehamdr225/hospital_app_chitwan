import 'dart:io';

import 'package:eMed/UI/Widget/FRaisedButton.dart';
import 'package:eMed/UI/Widget/InputForm.dart';
import 'package:eMed/UI/core/atoms/Indicator.dart';
import 'package:eMed/UI/core/atoms/SnackBar.dart';
import 'package:eMed/UI/core/atoms/WhiteAppBar.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/UI/resetPassword.dart';
import 'package:eMed/state/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File _profileImg;
  final picker = ImagePicker();
  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null)
      setState(() {
        _profileImg = File(pickedFile.path);
      });
  }

  Map<String, String> updateData = {};
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    var size = MediaQuery.of(context).size;
    final userDataStore = Provider.of<UserDataStore>(context);
    final user = userDataStore.user;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(
            elevation: 0.0,
            backgroundColor: theme.primary,
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
                  color: theme.primary,
                  child: CircleAvatar(
                    radius: 55.0,
                    backgroundColor: theme.primary,
                    child: CircleAvatar(
                      backgroundColor: theme.background,
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
                              user.name.split(' ').reduce((a, b) {
                                return '${a[0]} ${b[0]}';
                              }),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      color: theme.primary,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700),
                            ),
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
                  bg: theme.primary,
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
              padding: const EdgeInsets.all(10.0),
              child: InputField(
                value: user != null ? user.name ?? '' : '',
                title: 'Name',
                onChanged: (value) => setState(() {
                  updateData = {...updateData, 'name': value};
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InputField(
                value: user != null ? user.email ?? '' : '',
                title: 'Email',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: InputField(
                value: user != null ? user.phone ?? '' : '',
                title: 'Contact',
                onChanged: (value) => setState(() {
                  updateData = {...updateData, 'phone': value};
                }),
              ),
            ),
            Container(
                alignment: Alignment.topRight,
                child: FRaisedButton(
                  width: size.width * 0.50,
                  elevation: 0.0,
                  text: "Save Changes",
                  bg: theme.background,
                  color: blueGrey,
                  fontWeight: FontWeight.w600,
                  borderColor: theme.background,
                  onPressed: () async {
                    if (updateData.length > 0) {
                      setState(() {
                        isActive = true;
                      });
                      final result = await userDataStore.update(updateData);
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
              color: theme.onPrimary,
              bg: theme.background,
              borderColor: theme.background,
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              height: 45.0,
              elevation: 0.0,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPassword(
                              email: user.email,
                              signout: userDataStore.clearState,
                            )));
              },
            ),
            FRaisedButton(
              text: 'Deactivate Account',
              color: theme.onPrimary,
              bg: theme.background,
              borderColor: theme.background,
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
              color: theme.secondary,
              bg: theme.background,
              borderColor: theme.background,
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              height: 45.0,
              elevation: 0.0,
              onPressed: () {
                // Navigator.push(context,
                //           MaterialPageRoute(builder: (context) => ChangePassword()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
