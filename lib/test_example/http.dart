// ignore_for_file: unused_import, unnecessary_new
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyHttp());
// }

class NwHttp {
  // const MyHttp({Key? key}) : super(key: key);

  Future<String> fetchPost(url, Map<String, dynamic> map) async {
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(map));

    return response.body;
  }

  Future<String> fetchGet(url) async {
    final response = await http
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    return response.body;
  }
}
