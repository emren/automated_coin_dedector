import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum BoolString { Fake, Real }

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
  bool shouldEmit = true;

  Random _random = new Random();

  final _myController = BehaviorSubject<BoolString>.seeded(BoolString.Real);
  late StreamSubscription<BoolString> subscription;

  get myController => _myController;

  Sink<BoolString> get mySteamInputSink => _myController.sink;

  Stream<BoolString> get myStream => _myController.stream;

  String get getNameOfBoolString => _myController.value.name;
  bool get checkHasValue => _myController.hasValue;

  void pause() {
    shouldEmit = false;
    notifyListeners();
  }

  void resume() {
    shouldEmit = true;
    initBoolStream();
    notifyListeners();
  }

  Future<void> initBoolStream() async {
    while (shouldEmit) {
      //while (true) {
      subscription = _myController.stream.listen((value) {});
      await Future.delayed(Duration(seconds: 3), () {
        var boolean = _random.nextBool();
        BoolString bString;
        print(boolean);
        if (boolean) {
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
