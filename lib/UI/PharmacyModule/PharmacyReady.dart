import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';

class PharmacyReady extends StatefulWidget {
  @override
  _PharmacyReadyState createState() => _PharmacyReadyState();
}

class _PharmacyReadyState extends State<PharmacyReady> {
  String _medicineName;

  int _quantity;

  int _price;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('$_medicineName $_quantity $_price');
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    _buildAddFieldWidget() {
      return Container(
        height: 190,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: FForms(
                  borderColor: theme.primary,
                  formColor: Colors.white,
                  text: "Medicine Name",
                  type: TextInputType.text,
                  textColor: blueGrey.withOpacity(0.7),
                  width: size.width * 0.95,
                  validator: (val) =>
                      val.isEmpty ? 'Name of medicine is required' : null,
                  onSaved: (value) {
                    _medicineName = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FForms(
                      type: TextInputType.number,
                      borderColor: theme.primary,
                      formColor: Colors.white,
                      text: "Quatity",
                      textColor: blueGrey.withOpacity(0.7),
                      width: size.width * 0.40,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Quantity is reqired';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _quantity = value;
                      },
                    ),
                    SizedBox(width: 10.0),
                    FForms(
                      borderColor: theme.primary,
                      formColor: Colors.white,
                      text: "Price",
                      type: TextInputType.number,
                      textColor: blueGrey.withOpacity(0.7),
                      width: size.width * 0.515,
                      validator: (val) =>
                          val.isEmpty ? 'Price is required' : null,
                      onSaved: (value) {
                        _price = value;
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: WhiteAppBar(
              title: "Pharmacy Ready",
              titleColor: theme.primary,
            )),
        backgroundColor: theme.background,
        body: ListView(
          children: [
            // addField,
            _buildAddFieldWidget(),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: FancyText(
                        text: "Add another field",
                        fontWeight: FontWeight.w500,
                        size: 15.0,
                      ),
                    )
                  ],
                ),
                onTap: () =>
                    _buildAddFieldWidget(), // when pressed new fields will be added below the original fields
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RowInput(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                defaultStyle: false,
                title: "Total Cost:  ",
                titleSize: 16.5,
                titleWeight: FontWeight.w300,
                caption: "Rs. 1000",
                capColor: theme.secondary,
                capSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 45.0,
                child: RaisedButton(
                  color: theme.primary,
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
                    _formKey.currentState.save();
                    // widget.appointment.firstName = _fName;
                    // widget.appointment.lastName = _lName;
                    // widget.appointment.phoneNum = _fPhone;

                    final uid = await AuthService.getCurrentUID();
                    print(uid);
                    // await db
                    //     .collection("users")
                    //     .document(uid)
                    //     .collection("appointments")
                    //     .add(widget.appointment.toJson());

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
            )
          ],
        ));
  }
}
