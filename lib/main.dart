import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/controller/controller_provider.dart';
import 'package:mirror_wall/model/globals.dart';
import 'package:mirror_wall/model/utils.dart';
import 'package:mirror_wall/screens/homePage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    }

    SharedPreferences preferences = await SharedPreferences.getInstance();

    List<String> listOfBookMarks = await preferences.getStringList('ListOfBookMarks') ?? [];
    List<String> listOfTitle = await preferences.getStringList('ListOfTitle') ?? [];
    List<String> listOfLink = await preferences.getStringList('ListOfLink') ?? [];
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NetworkCheck_Provider()),
        ChangeNotifierProvider(create: (context) => ListOfBookMarks_Provider(listOfBookMarks_Model: ListOfBookMarks_Model(listOfBookMarks: listOfBookMarks))),
        ChangeNotifierProvider(create: (context) => ApplicationStartedLink_Provider()),
        ChangeNotifierProvider(create: (context)=> RadioButton_Provider()),
        ChangeNotifierProvider(create: (context) => LinearProgressIndicator_Provider()),
      ],
      builder: (context, _) {
        return Sizer(
          builder: (context, orientation, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme,
              routes: {
                '/' : (context) => const HomePage(),
              },
            );
          },
        );
      },
    ),
  );
}

