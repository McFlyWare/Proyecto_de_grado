import 'dart:convert';

import 'package:flutter/services.dart';

Future<String> obtainURL() async {
  final String response = await rootBundle.loadString('assets/keys/keys.json');
  final data = await json.decode(response);
  return data["base_url"];
}

Future<String> obtainKey() async {
  final String response = await rootBundle.loadString('assets/keys/keys.json');
  final data = await json.decode(response);
  return data["encryption_key"];
}

Future<String> obtainFireBaseToken() async {
  final String response = await rootBundle.loadString('assets/keys/keys.json');
  final data = await json.decode(response);
  return data["fire_base_token"];
}

Future<String> obtainAuthUrl() async {
  final String response = await rootBundle.loadString('assets/keys/keys.json');
  final data = await json.decode(response);
  return data["auth_url"];
}
