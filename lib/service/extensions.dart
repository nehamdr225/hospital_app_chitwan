import 'dart:io';

import 'package:chitwan_hospital/UI/pages/AppointmentPages/PCRAppointment.dart';

extension FileNameExtension on FileSystemEntity {
  String get basename => this?.path?.split('/')?.last;
}

extension GenderExtension on Gender {
  String get string {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
      default:
        return null;
    }
  }

  Gender fromString(String value) {
    switch (value) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return null;
    }
  }
}

extension BoolExtension on BoolEnum {
  bool get boolean {
    switch (this) {
      case BoolEnum.yes:
        return true;
      case BoolEnum.no:
        return false;
      case BoolEnum.unknown:
      default:
        return null;
    }
  }

  BoolEnum fromBoolean(bool value) {
    switch (value) {
      case true:
        return BoolEnum.yes;
      case false:
        return BoolEnum.no;
      default:
        return BoolEnum.unknown;
    }
  }
}
