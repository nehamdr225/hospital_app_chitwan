import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Hospital/HospitalPromoDetails.dart';
import 'package:chitwan_hospital/models/HospitalPromotion.dart';
import 'package:flutter/material.dart';

class HospitalPromo extends StatelessWidget {
  final List<HospitalPromotion> promotions;
  HospitalPromo({this.promotions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: promotions.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HospitalPromoDetails(
                    promo: promotions[index],
                  ))),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 8.0, right: 8.0, bottom: 10.0),
            child: Container(
              width: size.width * 0.60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: theme.primary,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white60,
                      offset: Offset(-4, -4),
                      blurRadius: 3.0),
                  BoxShadow(
                    color: Color(0xffffffff),
                    offset: Offset(-.9, -.9),
                  ),
                  BoxShadow(
                      color: theme.primary.withOpacity(0.3),
                      offset: Offset(4, 4),
                      blurRadius: 3.0),
                  BoxShadow(
                      color: theme.primary.withOpacity(0.3),
                      offset: Offset(.9, .9),
                      blurRadius: 1.0),
                ],
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Container(
                      width: size.width * 0.95,
                      height: 170.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(promotions[index].image),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.black38,
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FancyText(
                            letterSpacing: 1.0,
                            text: promotions[index].title,
                            color: textDark_Yellow,
                            size: 17.0,
                            fontWeight: FontWeight.w600),
                        RowInput(
                          title: "Date:  ",
                          titleColor: textDark_Yellow,
                          defaultStyle: false,
                          caption:
                              "${promotions[index].fromDate.split('T')[0]} to ${promotions[index].fromDate.split('T')[0]}",
                          capColor: textDark_Yellow,
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                      ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
