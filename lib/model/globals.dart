// ignore_for_file: camel_case_types
import 'dart:async';

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