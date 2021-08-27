import 'dart:async';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'card_model.dart';
import 'enums.dart';

class BoolStreamProvider extends ChangeNotifier {
  bool shouldEmit = true;

  Random _random = new Random();

  //final _myController = BehaviorSubject<BoolString>.seeded(BoolString.Real);
  // final _myController = BehaviorSubject<CardModel>.seeded(
  //     CardModel(bString: BoolString.Real, time: DateTime.now()));
  final _myController = ReplaySubject<CardModel>();

  late StreamSubscription<BoolString> subscription;

  get myController => _myController;

  //Sink<BoolString> get mySteamInputSink => _myController.sink;
  Sink<CardModel> get mySteamInputSink => _myController.sink;

  //Stream<BoolString> get myStream => _myController.stream;
  Stream<CardModel> get myStream => _myController.stream;

  //String get getNameOfBoolString => _myController.value.bString.name;
  String get getNameOfBoolString => _myController.values.last.bString.name;
  //bool get checkHasValue => _myController.hasValue;
  Future<bool> get checkHasValue async => await _myController.isEmpty;

  Future<List<CardModel>> getMyCardList() async {
    return await _myController.stream.toList();
  }

  void pause() {
    shouldEmit = false;
    notifyListeners();
  }

  void resume() {
    shouldEmit = true;
    initBoolStream();
    notifyListeners();
  }

  Future<void> playSound() async {
    final assetsAudioPlayer = AssetsAudioPlayer();

    assetsAudioPlayer.open(
      Audio("assets/sound_asset.mp3"),
    );
    assetsAudioPlayer.play();
  }

  Future<void> initBoolStream() async {
    while (shouldEmit) {
      //while (true) {
      //subscription = _myController.stream.listen((value) {});
      await Future.delayed(Duration(seconds: 3), () {
        var boolean = _random.nextBool();
        BoolString bString;
        print(boolean);
        if (boolean) {
          bString = BoolString.Real;
          playSound();
        } else {
          bString = BoolString.Fake;
        }
        //mySteamInputSink.add(bString);
        var model = CardModel(bString: bString, time: DateTime.now());
        mySteamInputSink.add(model);
        model.log();
        //print(_myController.value);
      });
    }
  }
}
