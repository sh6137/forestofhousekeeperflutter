import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'search.dart' as search;
import 'home.dart' as home;
import 'map.dart' as map;

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [home.Home(), map.KakaoMapTest()][tab],
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: '병원 약국'),
        ],
      ),
    );
  }
}
