import 'dart:io';

extension FileNameExtension on FileSystemEntity {
  String get basename => this?.path?.split('/')?.last;
}
