import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PrescriptionView extends StatelessWidget {
  final List images;
  PrescriptionView({this.images});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              elevation: 1.0,
              backgroundColor: theme.primary,
              color: textDark_Yellow,
              title: "Prescription",
              titleColor: textDark_Yellow,
            ),
            preferredSize: Size.fromHeight(50.0)),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: theme.background,
              ),
              padding: EdgeInsets.all(10.0),
              child: Text("Swipe -->")),
        ),
        body: PhotoViewGallery.builder(
            itemCount: images.length,
            backgroundDecoration: BoxDecoration(
              color: theme.background,
            ),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(images[index]));
            }));
  }
}
