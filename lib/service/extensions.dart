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

extension OccupationExtension on Occupation {
  String get string {
    switch (this) {
      case Occupation.health_worker:
        return 'Health worker';
      case Occupation.lab_worker:
        return 'Lab worker';
      case Occupation.student:
        return 'Student';
      case Occupation.with_animal:
        return 'With animal';
      case Occupation.others:
        return 'Others';
      default:
        return 'Others';
    }
  }

  Occupation fromString(String value) {
    switch (value) {
      case 'Health worker':
        return Occupation.health_worker;
      case 'Lab Worker':
        return Occupation.lab_worker;
      case 'Student':
        return Occupation.student;
      case 'With animal':
        return Occupation.with_animal;
      case 'Others':
        return Occupation.others;
      default:
        return Occupation.others;
    }
  }
}
