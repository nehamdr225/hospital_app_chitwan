import 'package:chitwan_hospital/UI/PharmacyModule/PharmacyModule.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/state/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RejectRemarkForm extends StatefulWidget {
  final id;
  RejectRemarkForm({this.id});
  @override
  _RejectRemarkFormState createState() => _RejectRemarkFormState();
}

class _RejectRemarkFormState extends State<RejectRemarkForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _remark;

  @override
  Widget build(BuildContext context) {
    final pharmacyDataStore = Provider.of<PharmacyDataStore>(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: WhiteAppBar(
              titleColor: theme.colorScheme.primary, title: "Inquiry")),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
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
                  Icons.comment,
                  color: theme.iconTheme.color,
                ),
                text: "Rejection Remark",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) =>
                    val.isEmpty || val.length < 8 ? 'Remark is required' : null,
                onChanged: (value) {
                  setState(() {
                    _remark = value;
                  });
                },
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
                    _formKey.currentState.save();
                    pharmacyDataStore.setOrderRemark(widget.id, _remark);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PharmacyModule()),
                        (Route<dynamic> route) => false);
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
