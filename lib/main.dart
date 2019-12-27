import 'package:flutter/material.dart';
import 'package:flutter03/common/global.dart';
import 'package:flutter03/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then((e)=>runApp(MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider.value(value: ThemeModel(),),
          ChangeNotifierProvider.value(value: UserModel(),),
          ChangeNotifierProvider.value(value: LocaleModel(),),
      ],
    );
  }
}