import 'dart:io';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/SnackBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/models/PharmacyAppointment.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum PickupOptions { pickup, delivery }

class PharmacyForm extends StatefulWidget {
  // final PharmacyAppointment pharmacyForm;
  final doctor;
  final department;
  final order;
  final id;
  PharmacyForm({this.doctor, this.department, this.order, this.id, Key key})
      : super(key: key);
  @override
  _PharmacyFormState createState() => _PharmacyFormState();
}

class _PharmacyFormState extends State<PharmacyForm> {
  PharmacyAppointment pharmacyFormData = PharmacyAppointment();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  PickupOptions _poptions = PickupOptions.pickup;
  List name = [];
  File _image;
  final picker = ImagePicker();
  bool isActive = false;
  double imageStatus = 0.0;
  String medicineValue;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile.path != null)
      setState(() {
        _image = File(pickedFile.path);
      });
  }

  @override
  Widget build(BuildContext context) {
    final userDataStore = Provider.of<UserDataStore>(context);
    final theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    if (pharmacyFormData.name == null || pharmacyFormData.phone == null) {
      setState(() {
        pharmacyFormData =
            PharmacyAppointment.fromJson(userDataStore.user.toJson()
              ..addAll({
                'pickUp': 'pickup',
                'medicine': widget.order,
                'userId': userDataStore.user.uid,
                'pharmacyId': widget.id,
                'pharmacyName': widget.doctor,
              }));
      });
    }
    Dialog dialog = Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10)),
          Text(
            'Uploading Image',
            style: TextStyle(color: textDark_Yellow),
          ),
          Padding(padding: EdgeInsets.all(10)),
          LinearProgressIndicator(
            value: imageStatus,
          ),
          Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
    handleSubmit(String uri) {
      userDataStore.orderMedicine({
        ...pharmacyFormData.toJson(),
        if (uri != null) 'image': uri
      }).then((bool result) {
        setState(() {
          isActive = false;
        });
        if (result) {
          buildAndShowFlushBar(
            context: context,
            icon: Icons.check,
            text: 'Medicine ordered sucessfully!',
          );
          Future.delayed(Duration(seconds: 2)).then(
            (_) => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false),
          );
        } else {
          buildAndShowFlushBar(
            context: context,
            icon: Icons.error_outline,
            text: 'Error ocurred!',
            backgroundColor: Theme.of(context).colorScheme.error,
          );
        }
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(41.0),
        child: WhiteAppBar(
          titleColor: theme.colorScheme.primary,
          title: "Order Form",
          bottom: PreferredSize(
              child: BoolIndicator(isActive),
              preferredSize: Size.fromHeight(1.0)),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      persistentFooterButtons: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: SizedBox(
            height: 45.0,
            width: width,
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
                      if (pharmacyFormData.name == null ||
                          pharmacyFormData.phone == null ||
                          pharmacyFormData.address == null) {
                        buildAndShowFlushBar(
                          context: context,
                          text: 'Please provide all data!',
                          backgroundColor: theme.colorScheme.error,
                          icon: Icons.error_outline,
                        );
                        return;
                      }
                      _formKey.currentState.save();
                      pharmacyFormData.timestamp =
                          DateTime.now().toIso8601String();
                      setState(() {
                        isActive = true;
                      });
                      if (_image != null) {
                        showDialog(
                            context: context, builder: (context) => dialog);
                        final uploadTask = userDataStore.uploadFile(
                            _image, userDataStore.user.uid);
                        uploadTask.events.listen((event) async {
                          setState(() {
                            imageStatus = (event.snapshot.bytesTransferred /
                                    event.snapshot.totalByteCount)
                                .toDouble();
                          });
                          if (uploadTask.isComplete) {
                            Navigator.of(context, rootNavigator: true).pop();
                            final uri =
                                await event.snapshot.ref.getDownloadURL();
                            handleSubmit(uri);
                          }
                          print(event.snapshot.bytesTransferred);
                        });
                      }
                    },
            ),
          ),
        )
      ],
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
                //name
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  initialValue: userDataStore.user.name,
                  icon: Icon(
                    Icons.person,
                    color: theme.iconTheme.color,
                  ),
                  text: "Name",
                  type: TextInputType.phone,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) =>
                      val.isEmpty || val.length < 8 ? 'Name is required' : null,
                  onChanged: (value) {
                    pharmacyFormData.name = value;
                  },
                ),
              ),
              Padding(
                //phone number
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  initialValue: userDataStore.user.phone,
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
                    pharmacyFormData.phone = value;
                  },
                ),
              ),
              Padding(
                //Address
                padding: const EdgeInsets.all(10.0),
                child: FForms(
                  initialValue: userDataStore.user.address,
                  icon: Icon(
                    Icons.map,
                    color: theme.iconTheme.color,
                  ),
                  text: "Address",
                  type: TextInputType.text,
                  //width: width * 0.80,
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  textColor: blueGrey.withOpacity(0.7),
                  validator: (val) => val.isEmpty || val.length < 10
                      ? 'Your Address is required'
                      : null,
                  onChanged: (value) {
                    pharmacyFormData.address = value;
                  },
                ),
              ),
              if (widget.order != null)
                Padding(
                  //Medicine and Quatity
                  padding: const EdgeInsets.all(10.0),
                  child: FForms(
                    icon: Icon(
                      Icons.map,
                      color: theme.iconTheme.color,
                    ),
                    initialValue: widget.order,
                    text: "Medicine and Quantity",
                    type: TextInputType.text,
                    //width: width * 0.80,
                    borderColor: theme.colorScheme.primary,
                    formColor: Colors.white,
                    textColor: blueGrey.withOpacity(0.7),
                    onChanged: (value) {
                      pharmacyFormData.medicine = value;
                    },
                  ),
                ),
              Padding(
                //gender
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 0.0),
                child: Row(
                  children: <Widget>[
                    FancyText(
                      text: "Pickup Options: ",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 10.0),
                    Radio(
                      value: PickupOptions.pickup,
                      activeColor: theme.iconTheme.color,
                      groupValue: _poptions,
                      onChanged: (PickupOptions value) {
                        setState(() {
                          _poptions = PickupOptions.pickup;
                          pharmacyFormData.pickUp = 'pickup';
                        });
                      },
                    ),
                    FancyText(
                      text: "Pick-Up",
                      size: 15.0,
                      color: blueGrey.withOpacity(0.9),
                    ),
                    Radio(
                      value: PickupOptions.delivery,
                      activeColor: theme.iconTheme.color,
                      groupValue: _poptions,
                      onChanged: (PickupOptions value) {
                        setState(() {
                          _poptions = PickupOptions.delivery;
                          pharmacyFormData.pickUp = 'delivery';
                        });
                      },
                    ),
                    FancyText(
                      text: "Delivery",
                      size: 15.0,
                      color: blueGrey.withOpacity(0.9),
                    ),
                  ],
                ),
              ),
              _poptions == PickupOptions.delivery
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                      child: FancyText(
                        text: 'Delivery charge Rs.100',
                        color: blueGrey.withOpacity(0.6),
                        textAlign: TextAlign.start,
                      ),
                    )
                  : Text(' '),
              
              Padding(
                //upload prescription
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FancyText(
                      text: "Or",
                      size: 16.0,
                      color: blueGrey,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height:10.0),
                    FancyText(
                      text: "Upload Prescription: ",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _image == null
                        ? IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 26.0,
                              color: theme.colorScheme.primary,
                            ),
                            onPressed: getImage,
                          )
                        : InkWell(
                            onTap: getImage,
                            child: Stack(children: <Widget>[
                              Container(
                                  height: 100.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(border: Border.all()),
                                  child: Image.file(_image)),
                              Container(
                                height: 100.0,
                                width: 100.0,
                                color: Colors.black26,
                              ),
                            ]),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
