import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BoolStreamProvider extends ChangeNotifier {
  Random random = new Random();

  final _myController = BehaviorSubject<bool>();

  get myController => _myController;

  Sink<bool> get mySteamInputSink => _myController.sink;

  Stream<bool> get myStream => _myController.stream;

  Future<void> initBoolStream() async {
    while (true) {
      await Future.delayed(Duration(seconds: 3), () {
        var boolean = random.nextBool();
        print(boolean);
        mySteamInputSink.add(boolean);
        print(_myController.value);
      });
    }
  }
}
