import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/Widget/InputForm.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final AuthService _auth = AuthService();
    // final user = AuthService().user;
    final theme = Theme.of(context).colorScheme;
    var size = MediaQuery.of(context).size;
    //final user = Provider.of<UserModel>(context);
    //final userData = user.user;
    //final token = user.token;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(
            elevation: 0.0,
            backgroundColor: theme.primary ,
            color: Colors.white,
            // onPressed: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => HomePageApp()));
            // },
          )),
      body: FutureBuilder(
          future: Provider.of<AuthService>(context).getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top:20.0),
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
                          child:
                              // userData['media'] != null
                              //     ? Image.network(userData['media'])
                              //:
                              Text(
                            snapshot.data.displayName
                                .split(' ')
                                .reduce((a, b) {
                              return '${a[0]} ${b[0]}';
                            }),
                            style: Theme.of(context).textTheme.body1.copyWith(
                                color: theme.primary,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: InputField(
                        value: "${snapshot.data.displayName}",
                        title: 'Name',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InputField(
                        value: "${snapshot.data.email}",
                        title: 'Email',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top:10.0, left:10.0, right:10.0),
                      child: InputField(
                        value: "9840056679",
                        title: 'Contact',
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
                          onPressed: () {},
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(height: 20.0),
                    FRaisedButton(
                      text: 'Change Password',
                      color: theme.onPrimary,
                      bg: theme.background,
                      borderColor: theme.background,
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
                  ]);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
