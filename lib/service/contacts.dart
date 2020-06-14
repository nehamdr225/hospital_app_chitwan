import 'dart:convert';
import 'package:flutter/services.dart';

Future contactFetcher() async {
  final response = await rootBundle.loadString('assets/contacts.json');
  return json.decode(response);
}