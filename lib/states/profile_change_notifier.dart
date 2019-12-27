import 'package:flutter/material.dart';
import 'package:flutter03/common/global.dart';
import 'package:flutter03/models/index.dart';

class ProfileChangeNotifier extends ChangeNotifier{

  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    
    Global.saveProfile();
    super.notifyListeners();
  }

}

class UserModel extends ProfileChangeNotifier{
  User get user => _profile.user;

  bool get isLogin => user != null;

  set user(User user){
    if(user?.login != _profile.user?.login){
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier{
  ColorSwatch get theme => Global.themes.firstWhere((e)=>e.value == _profile.theme,orElse: ()=>Colors.blue);

  set theme(ColorSwatch color){
    if(color != theme){
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}


class LocaleModel extends ProfileChangeNotifier{
  Locale getLocale(){
    if(_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    return Locale(t[0],t[1]);
  }

  String get local => _profile.locale;

  set locale(String locale){
    if(locale != _profile.locale){
      _profile.locale = locale;
      notifyListeners();
    }
  }
}