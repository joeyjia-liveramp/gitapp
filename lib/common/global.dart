import 'package:flutter/material.dart';
import 'package:flutter03/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
    Colors.blue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.red,
];


class Global{
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  static CacheConfig netCache = CacheConfig();

  static List<MaterialColor> get themes => _themes;
  

}