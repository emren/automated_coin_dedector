import 'enums.dart';

class CardModel{
  late BoolString bString;
  late DateTime time;

  CardModel({required this.bString, required this.time});

  void log() =>
      print('CardModel: $bString $time');
}