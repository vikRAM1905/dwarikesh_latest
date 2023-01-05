import 'dart:async';

import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:http/http.dart' as http;

class Request {
  final String? url;
  final dynamic body;
  final Map<String, String> headers = {
    "Accept": "application/json",
    "Authorization": "Bearer ${Prefs.getString(TOKEN)} "
  };

  Request({this.url, this.body});

  Future<http.Response> post() {
    print(
        'REQUEST DATA :-   URL IS = ${url} || body = ${body}  || Bearer ${Prefs.getString(TOKEN)}');
    return http
        .post(Uri.parse(url!), body: body, headers: headers)
        .timeout(Duration(minutes: 2), onTimeout: () {
      throw TimeoutException("connection time out try agian");
    });
  }

  Future<http.Response> get() {
    print(
        'REQUEST DATA :-   URL IS = ${url} || body = ${body}  || Bearer ${Prefs.getString(TOKEN)}');
    return http
        .get(Uri.parse(url!), headers: headers)
        .timeout(Duration(minutes: 2), onTimeout: () {
      throw TimeoutException("connection time out try agian");
    });
  }
}
