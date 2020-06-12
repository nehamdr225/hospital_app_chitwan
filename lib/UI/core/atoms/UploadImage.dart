import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  UploadImage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

//   Future<void> retrieveLostData() async {
//   final LostData response =
//       await picker.getLostData();
//   if (response == null) {
//     return;
//   }
//   if (response.file != null) {
//     setState(() {
//       if (response.type == RetrieveType.image) {
//         _handleImage(response.file);
//       } else {
//         _handleImage(response.file);
//       }
//     });
//   } else {
//     _handleError(response.exception);
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _image == null ? Text("No image selected.") : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
