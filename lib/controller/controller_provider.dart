import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirror_wall/model/globals.dart';
import 'package:mirror_wall/model/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkCheck_Provider extends ChangeNotifier {
  Connectivity connectivity = Connectivity();

  NetworkCheck_Model networkCheck_Model = NetworkCheck_Model(connectivityStatus: "Waiting");

  void checkInternetConnectivity(){
    networkCheck_Model.connectivityStream = connectivity.onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      switch(connectivityResult){
        case ConnectivityResult.wifi:
          networkCheck_Model.connectivityStatus = "Wi-fi";
          break;
        case ConnectivityResult.ethernet:
          networkCheck_Model.connectivityStatus = "Ethernet";
          break;
        case ConnectivityResult.bluetooth:
          networkCheck_Model.connectivityStatus = "Bluetooth";
          break;
        case ConnectivityResult.mobile:
          networkCheck_Model.connectivityStatus = "Mobile";
          break;
        case ConnectivityResult.vpn:
          networkCheck_Model.connectivityStatus = "VPN";
          break;
        case ConnectivityResult.other:
          networkCheck_Model.connectivityStatus = "Other";
          break;
        default:
          networkCheck_Model.connectivityStatus = "Waiting";
          break;
      }
    });
  }
}

class ListOfBookMarks_Provider extends ChangeNotifier{
  ListOfBookMarks_Model listOfBookMarks_Model;

  ListOfBookMarks_Provider({required this.listOfBookMarks_Model,});

  initialization() async {

    listOfBookMarks_Model.listOfBookMarks.add(await inAppWebViewController?.getTitle() as String);

     SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setStringList('ListOfBookMarks', listOfBookMarks_Model.listOfBookMarks as List<String>);
    notifyListeners();
  }
}

class ApplicationStartedLink_Provider extends ChangeNotifier{
  ApplicationStartedLink_Model applicationStartedLink_Model =ApplicationStartedLink_Model(uri: "https://www.google.com/");

  initialization(uri){
    applicationStartedLink_Model.uri = uri;
    notifyListeners();
  }

}

class RadioButton_Provider extends ChangeNotifier {
  RadioButton_Model radioButton_Model = RadioButton_Model(groupValue: 1);

  initialization(int groupValue){
    radioButton_Model.groupValue = groupValue;
    notifyListeners();
  }
}

class LinearProgressIndicator_Provider extends ChangeNotifier{
  LinearProgressIndicator_Model linearProgressIndicator_Model = LinearProgressIndicator_Model(progress: 0);

  initialization(progress){
    linearProgressIndicator_Model.progress = progress / 100;
    notifyListeners();
  }
}