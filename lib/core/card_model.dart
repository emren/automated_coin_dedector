import 'enums.dart';

class CardModel {
  late BoolString bString;
  late DateTime time;

  CardModel({required this.bString, required this.time});

  String log() => 'CardModel: $bString $time';
}
