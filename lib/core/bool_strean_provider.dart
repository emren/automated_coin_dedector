import 'dart:async';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:developer' as dev;

import 'card_model.dart';
import 'enums.dart';

class BoolStreamProvider extends ChangeNotifier {
  bool shouldEmit = true;

  Random _random = new Random();

  final _myController = ReplaySubject<CardModel>();

  late StreamSubscription<BoolString> subscription;

  get myController => _myController;

  Sink<CardModel> get mySteamInputSink => _myController.sink;

  Stream<CardModel> get myStream => _myController.stream;

  String get getNameOfBoolString => _myController.values.last.bString.name;

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

  String getTimeAgo(CardModel card) {
    var ago = DateTime.now().subtract(DateTime.now().difference(card.time));
    return timeago.format(ago);
  }

  Future<void> initBoolStream() async {
    while (shouldEmit) {
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
        var model = CardModel(bString: bString, time: DateTime.now());
        mySteamInputSink.add(model);
        dev.log(model.log());
      });
    }
  }
}
