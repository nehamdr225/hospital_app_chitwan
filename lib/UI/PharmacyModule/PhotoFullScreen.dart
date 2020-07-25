import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import "package:flutter/material.dart";
import 'package:photo_view/photo_view.dart';

class PhotoFullScreen extends StatelessWidget {
  final image;
  PhotoFullScreen({this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(), preferredSize: Size.fromHeight(50.0)),
      body: PhotoView(
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              backgroundColor: blueGrey.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation(blueGrey),
            ),
          ),
        ),
        minScale: PhotoViewComputedScale.contained * 0.9,
        initialScale: PhotoViewComputedScale.contained * 1.1,
        imageProvider: NetworkImage(image),
        backgroundDecoration: BoxDecoration(
          color: Colors.grey[300],
          
        ),
      ),
    );
  }
}
