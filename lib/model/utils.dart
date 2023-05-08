import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 20,
        color: Colors.deepPurple,
        fontWeight: FontWeight.w400,
      )
    )
  );
}

enum SampleItem { itemOne, itemTwo, itemThree }


late PullToRefreshController pullRefreshController;

List<dynamic> listOfTitle = [];
List<dynamic> listOfLink = [];
InAppWebViewController? inAppWebViewController;

List web = [

];

TextEditingController textEditingController = TextEditingController();