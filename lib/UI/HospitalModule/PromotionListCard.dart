import 'package:eMed/UI/HospitalModule/PromotionDetail.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/RowInput.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionListCard extends StatefulWidget {
  final id;
  PromotionListCard({this.id});
  @override
  _PromotionListCardState createState() => _PromotionListCardState();
}

class _PromotionListCardState extends State<PromotionListCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final promotion = Provider.of<HospitalDataStore>(context)
        .promotions
        .firstWhere((element) => element.id == widget.id);

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PromotionDetail(id: promotion.id)));
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, left: 8.0, right: 8.0, bottom: 10.0),
        child: Container(
          width: size.width * 0.95,
          height: 170.0,
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
                        image: NetworkImage(promotion.image),
                        fit: BoxFit.contain),
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
                        text: promotion.title,
                        color: textDark_Yellow,
                        size: 17.0,
                        fontWeight: FontWeight.w600),
                    RowInput(
                      title: "",
                      titleColor: textDark_Yellow,
                      defaultStyle: false,
                      caption: promotion.fromDate.split('T')[0] +
                          ' to ' +
                          promotion.toDate.split('T')[0],
                      capColor: textDark_Yellow,
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
