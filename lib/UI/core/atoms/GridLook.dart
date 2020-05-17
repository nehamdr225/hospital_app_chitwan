import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:flutter/material.dart';

class GridLook extends StatelessWidget {
  final src;
  final imgheight;
  final name;
  final caption;
  final wishlist;
  final onTap;
  GridLook(
      {this.src,
      this.imgheight,
      this.name,
      this.caption,
      this.wishlist,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.0, color: Colors.transparent),
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.background,
      ),
      child: InkWell(
        onTap: onTap,
        // () {
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => ProductDetails(id: id)));
        // },
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FancyText(
              text: name,
              size: 16.0,
            ),
            Container(
              height: 70.0,
              width: 70.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  src,
                  fit: BoxFit.fill,
                  //color: Theme.of(context).iconTheme.color,
                  // height: 60.0,
                  // width: 60.0,
                ),
              ),
            ),
            //Divider(),

            //SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }
}
