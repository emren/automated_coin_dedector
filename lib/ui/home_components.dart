import 'package:automated_coin_dedector/core/bool_strean_provider.dart';
import 'package:automated_coin_dedector/core/card_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:automated_coin_dedector/core/enums.dart';
import 'package:provider/provider.dart';

class ExpandableTile extends StatelessWidget {
  final CardModel model;
  const ExpandableTile({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boolStreamProvider = Provider.of<BoolStreamProvider>(context);
    return Card(
      color: Colors.yellow,
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          onExpansionChanged: (_){
            if(model.bString == BoolString.Real){
              boolStreamProvider.playSound();
            }
          },
          title: Center(child: Text(model.bString.name)),
          children: <Widget>[
            Text(DateFormat('yyyy-MM-dd – kk:mm').format(model.time)),
          ],
        ),
      ),
    );
  }
}
