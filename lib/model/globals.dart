import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NetworkCheck_Model {
  String connectivityStatus;
  StreamSubscription? connectivityStream;

  NetworkCheck_Model({
    required this.connectivityStatus,
    this.connectivityStream,
  });
}

class ListOfBookMarks_Model {
  List<String> listOfBookMarks;

  ListOfBookMarks_Model({required this.listOfBookMarks});
}

class ApplicationStartedLink_Model {
  dynamic uri;

  ApplicationStartedLink_Model({required this.uri});
}

class RadioButton_Model{
  int groupValue;

  RadioButton_Model({required this.groupValue});
}

class LinearProgressIndicator_Model{
  double progress;

  LinearProgressIndicator_Model({required this.progress});
}