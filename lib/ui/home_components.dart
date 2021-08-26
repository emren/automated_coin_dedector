import 'package:automated_coin_dedector/core/card_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpandableTile extends StatelessWidget {
  // final String str;
  // final DateTime time;
  final CardModel model;
  const ExpandableTile({Key? key,   required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(model.bString.toString()),
          children: <Widget>[
            Text(DateFormat('yyyy-MM-dd – kk:mm').format(model.time)),
          ],
        ),
      ),
    );
  }
}
