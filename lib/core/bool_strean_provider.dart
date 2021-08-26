import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';


enum BoolString {Fake, Real}

extension BoolStringNameExtension on BoolString {
  String get name {
    switch (this) {
      case BoolString.Fake:
        return 'Fake';
      case BoolString.Real:
        return 'Real';

    }
  }
}
class BoolStreamProvider extends ChangeNotifier {

  Random random = new Random();

  final _myController = BehaviorSubject<BoolString>();

  get myController => _myController;

  Sink<BoolString> get mySteamInputSink => _myController.sink;

  Stream<BoolString> get myStream => _myController.stream;

  Future<void> initBoolStream() async {
    while (true) {
      await Future.delayed(Duration(seconds: 3), () {
        var boolean = random.nextBool();
        BoolString bString;
        print(boolean);
        if(boolean) {
          bString = BoolString.Real;
        } else {
          bString = BoolString.Fake;
        }
        mySteamInputSink.add(bString);
        print(_myController.value);
      });
    }
  }
}
