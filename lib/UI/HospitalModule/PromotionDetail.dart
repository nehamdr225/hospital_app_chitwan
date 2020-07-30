import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/SnackBar.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/service/database.dart';
import 'package:eMed/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionDetail extends StatefulWidget {
  final id;
  PromotionDetail({this.id});

  @override
  _PromotionDetailState createState() => _PromotionDetailState();
}

class _PromotionDetailState extends State<PromotionDetail> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final hospitalDataStore = Provider.of<HospitalDataStore>(context);
    final promotion = hospitalDataStore.promotions
        .firstWhere((element) => element.id == widget.id);

    final dialog = AlertDialog(
      actions: <Widget>[
        InkWell(
          child: FancyText(text: "Cancel", color: theme.secondary),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: 4.0),
        ActionChip(
          label: FancyText(
            text: "Archive",
            color: textDark_Yellow,
          ),
          backgroundColor: Colors.green.shade400,
          onPressed: isActive
              ? null
              : () async {
                  setState(() {
                    isActive = true;
                  });
                  await DatabaseService.archivePromotion(promotion.id);
                  setState(() {
                    isActive = false;
                  });
                  Navigator.of(context).pop();
                  buildAndShowFlushBar(
                    context: context,
                    text: 'Promotion has been archived!',
                    icon: Icons.check,
                  );
                },
        ),
      ],
      content: FancyText(
          textOverflow: TextOverflow.visible,
          textAlign: TextAlign.start,
          text: "Are you sure you want to archive this promotion?",
         
          size: 15.0,
          fontWeight: FontWeight.w400,
          color: blueGrey),
    );

    return Scaffold(
      backgroundColor: theme.background,
      floatingActionButton: promotion.isArchived == false
          ? FloatingActionButton.extended(
              onPressed: () {
                showDialog(context: context, builder: (context) => dialog);
              },
              icon: Icon(
                Icons.archive,
                color: textDark_Yellow,
              ),
              label: FancyText(
                text: "Archive",
                color: textDark_Yellow,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: theme.primary,
            )
          : SizedBox.shrink(),
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
          elevation: 0.0,
          backgroundColor: theme.primary,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: FancyText(
                  text: promotion.title,
                  color: textDark_Yellow,
                  size: 15.0,
                ),
              ),
              background: Container(
                width: size.width,
                height: size.height * 0.6,
                child: Image.network(
                  promotion.image,
                  fit: BoxFit.contain,
                ),
              )),
        ),
        if (promotion.isArchived)
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(left: 44.0, top: 0.0),
            child: FancyText(
              text: 'This promotion has been archived!',
              fontWeight: FontWeight.w500,
              size: 16.0,
              textAlign: TextAlign.start,
              color: Colors.red,
            ),
          )),
        if (!promotion.isArchived)
          SliverToBoxAdapter(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 44.0, top: 10.0),
            child: Row(
              children: <Widget>[
                FancyText(
                  textOverflow: TextOverflow.visible,
                  text: 'From:   ',
                  color: blueGrey.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  size: 15.5,
                  textAlign: TextAlign.start,
                ),
                FancyText(
                  textOverflow: TextOverflow.visible,
                  text: promotion.fromDate.split('T')[0],
                  fontWeight: FontWeight.w500,
                  size: 16.0,
                  textAlign: TextAlign.start,
                ),
                FancyText(
                  textOverflow: TextOverflow.visible,
                  text: '   To:   ',
                  color: blueGrey.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  size: 15.5,
                  textAlign: TextAlign.start,
                ),
                FancyText(
                  textOverflow: TextOverflow.visible,
                  text: promotion.toDate.split('T')[0],
                  fontWeight: FontWeight.w500,
                  size: 16.0,
                  textAlign: TextAlign.start,
                ),
              ],
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
                    textAlign: TextAlign.justify,
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
