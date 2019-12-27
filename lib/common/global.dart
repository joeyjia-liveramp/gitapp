import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter03/common/net_cache.dart';
import 'package:flutter03/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'git_api.dart';

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
  static NetCache netCache = NetCache();

  static List<MaterialColor> get themes => _themes;

  static bool get isRelease => bool.fromEnvironment("dart.vm.product");


  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if(_profile != null){
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    profile.cache = profile.cache ?? CacheConfig()
    ..enable = true
    ..maxAge = 3600
    ..maxCount = 100;

    Git.init();
  }
  
  static saveProfile() => _prefs.setString("profile", jsonEncode(profile.toJson()));

}