import 'package:chitwan_hospital/UI/PharmacyModule/PhotoFullScreen.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/models/HospitalPromotion.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HospitalPromoDetails extends StatelessWidget {
  final HospitalPromotion promo;
  const HospitalPromoDetails({Key key, this.promo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        child: WhiteAppBar(
          titleColor: theme.colorScheme.primary,
          title: promo.title,
        ),
        preferredSize: Size.fromHeight(50),
      ),
      backgroundColor: theme.colorScheme.background,
      body: ListView(
        children: <Widget>[
          Container(
            height: size.height * 0.6,
            child: PhotoView.customChild(
              child: InkWell(
                child: Image.network(promo.image),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PhotoFullScreen(
                            title: 'Promotion Image',
                            image: promo.image,
                          )));
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10.0),
            child: FancyText(
              text: 'Promotion By ' + promo.hospital,
              size: 18,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w600,
              textOverflow: TextOverflow.visible,
              color: theme.colorScheme.primaryVariant,
            ),
          ),
          if (promo.isArchived == null || promo.isArchived == false)
            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              child: FancyText(
                text: 'Valid from ' +
                    promo.fromDate.split('T')[0] +
                    ' to ' +
                    promo.toDate.split('T')[0],
                size: 14,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
                textOverflow: TextOverflow.visible,
                color: Colors.black54,
              ),
            ),
          if (promo.isArchived)
            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              child: FancyText(
                text: 'This promotion has expired!',
                size: 16,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
                textOverflow: TextOverflow.visible,
                color: Colors.red,
              ),
            ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10.0),
            child: FancyText(
              text: promo.description,
              size: 16,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w600,
              textOverflow: TextOverflow.visible,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
