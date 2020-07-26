import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/SnackBar.dart';
import 'package:chitwan_hospital/models/LabAppointment.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabForm extends StatefulWidget {
  final labId;
  LabForm({this.labId});
  @override
  _LabFormState createState() => _LabFormState();
}

class _LabFormState extends State<LabForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LabAppointment labAppointment = LabAppointment();
  // File _image;
  // final picker = ImagePicker();

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   if (pickedFile.path != null)
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  // }

  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userDataStore = Provider.of<UserDataStore>(context);
    if (labAppointment.name == null) {
      setState(() {
        labAppointment.name = userDataStore.user.name;
        labAppointment.uid = userDataStore.user.uid;
        labAppointment.phone = userDataStore.user.phone;
        labAppointment.email = userDataStore.user.email;
        labAppointment.labId = widget.labId;
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: WhiteAppBar(
          titleColor: theme.colorScheme.primary,
          title: "Order Form",
          bottom: PreferredSize(
              child: BoolIndicator(isActive),
              preferredSize: Size.fromHeight(1.0)),
        ),
      ),
      persistentFooterButtons: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 45.0,
            width: MediaQuery.of(context).size.width,
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
              onPressed: isActive || !_formKey.currentState.validate()
                  ? null
                  : () async {
                      if (!_formKey.currentState.validate()) {
                        buildAndShowFlushBar(
                          context: context,
                          text: 'Please provide all data!',
                          backgroundColor: theme.colorScheme.error,
                          icon: Icons.error_outline,
                        );
                        return;
                      }
                      labAppointment.timestamp =
                          DateTime.now().toIso8601String();
                      setState(() {
                        isActive = true;
                      });
                      final result = await userDataStore
                          .createLabOrder(labAppointment.toJson());
                      _formKey.currentState.save();
                      setState(() {
                        isActive = false;
                      });
                      if (result) {
                        buildAndShowFlushBar(
                          context: context,
                          text: 'Lab order created!',
                          icon: Icons.check,
                        );
                        await Future.delayed(Duration(seconds: 2));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false,
                        );
                      } else
                        buildAndShowFlushBar(
                          context: context,
                          text: 'Failed creating lab order!',
                          backgroundColor: theme.colorScheme.error,
                          icon: Icons.error_outline,
                        );
                    },
            ),
          ),
        )
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
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
                //phone number
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  icon: Icon(
                    Icons.title,
                    color: theme.iconTheme.color,
                  ),
                  text: "Title or Test Name",
                  type: TextInputType.text,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) => val.isEmpty || val.length < 10
                      ? 'Test name is required'
                      : null,
                  onChanged: (value) {
                    setState(() {
                      labAppointment.title = value;
                    });
                  },
                ),
              ),
              Padding(
                //phone number
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  icon: Icon(
                    Icons.person_outline,
                    color: theme.iconTheme.color,
                  ),
                  initialValue: labAppointment.name,
                  text: "Name",
                  type: TextInputType.phone,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) =>
                      val.isEmpty || val.length < 8 ? 'Name is required' : null,
                  onChanged: (value) {
                    setState(() {
                      labAppointment.name = value;
                    });
                  },
                ),
              ),
              Padding(
                //phone number
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  icon: Icon(
                    Icons.phone,
                    color: theme.iconTheme.color,
                  ),
                  text: "Phone Number",
                  type: TextInputType.phone,
                  //width: width * 0.80,
                  initialValue: labAppointment.phone,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) => val.isEmpty || val.length < 8
                      ? 'Phone Number is required'
                      : null,
                  onChanged: (value) {
                    setState(() {
                      labAppointment.phone = value;
                    });
                  },
                ),
              ),
              // Padding(
              //   //date
              //   padding:
              //       const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
              //       FancyText(
              //         text: "Upload Prescribed lab works: ",
              //         size: 16.0,
              //         fontWeight: FontWeight.w500,
              //         textAlign: TextAlign.left,
              //       ),
              //       SizedBox(
              //         height: 10.0,
              //       ),
              //       _image == null
              //           ? IconButton(
              //               icon: Icon(
              //                 Icons.add_a_photo,
              //                 size: 26.0,
              //                 color: theme.colorScheme.primary,
              //               ),
              //               onPressed: getImage,
              //             )
              //           : Row(children: <Widget>[
              //               InkWell(
              //                 onTap: getImage,
              //                 child: Stack(children: <Widget>[
              //                   Container(
              //                       height: 100.0,
              //                       width: 100.0,
              //                       decoration:
              //                           BoxDecoration(border: Border.all()),
              //                       child: Image.file(_image)),
              //                   Container(
              //                     height: 100.0,
              //                     width: 100.0,
              //                     color: Colors.black26,
              //                   ),
              //                 ]),
              //               ),
              //               SizedBox(
              //                 width: 8.0,
              //               ),

              //             ]),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
