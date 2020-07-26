import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionDetail extends StatelessWidget {
  final id;
  PromotionDetail({this.id});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final promotion = Provider.of<HospitalDataStore>(context)
        .promotions
        .firstWhere((element) => element.id == id);

    return Scaffold(
      backgroundColor: theme.background,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          expandedHeight: 250.0,
          floating: true,
          pinned: true,
          snap: true,
          elevation: 1.0,
          backgroundColor: theme.primary,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Text(promotion.title,
                    style: TextStyle(
                      color: theme.background,
                      fontSize: 15.0,
                    )),
              ),
              background: Stack(
                children: <Widget>[
                  Container(
                    height: 285.0,
                    color: theme.background,
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.6,
                    color: theme.primary,
                    child: Image.network(
                      promotion.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.only(left: 44.0, top: 0.0),
          child: FancyText(
            text:
                'From   ' + promotion.fromDate + '   To   ' + promotion.toDate,
            fontWeight: FontWeight.w500,
            size: 16.0,
            textAlign: TextAlign.start,
          ),
        )),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 14.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.details,
                    color: Colors.grey[500],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: FancyText(
                      text: "Details",
                      fontWeight: FontWeight.w500,
                      size: 19.0,
                      color: theme.primary.withOpacity(0.8),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 33.0, right: 20.0, top: 6.0),
                child: FancyText(
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    textAlign: TextAlign.left,
                    textOverflow: TextOverflow.visible,
                    color: Colors.black87,
                    size: 15.0,
                    text: promotion.description),
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
