import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter03/common/global.dart';
import 'package:flutter03/models/repo.dart';
import 'package:flutter03/models/user.dart';

class Git{


  BuildContext context;
  Options _options;

  Git([this.context]){
    _options = Options(extra: {"context":context});
  }

  static Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.github.com/',
    headers: {
      HttpHeaders.acceptHeader:"application/vnd.github.squirrel-girl-preview,"
      "application/vnd.github.symmetra-preview+json",
    },
  ));

  static void init(){
    dio.interceptors.add(Global.netCache);
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
  }

  Future<User> login(String login,String pwd) async{
    String basic = 'Basic' + base64.encode(utf8.encode('$login:$pwd'));
    var r = await dio.get("/users/$login",
      options: _options.merge(headers: {
        HttpHeaders.authorizationHeader: basic
      }, extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );

    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    Global.netCache.cache.clear();
    Global.profile.token = basic;
    return User.fromJson(r.data);
  }


   Future<List<Repo>> getRepos(
      {Map<String, dynamic> queryParameters, //query参数，用于接收分页信息
      refresh = false}) async {
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": true, "list": true});
    }
    var r = await dio.get<List>(
      "user/repos",
      queryParameters: queryParameters,
      options: _options,
    );
    return r.data.map((e) => Repo.fromJson(e)).toList();
  }

}