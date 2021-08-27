import 'package:automated_coin_dedector/core/bool_strean_provider.dart';
import 'package:automated_coin_dedector/core/card_model.dart';
import 'package:automated_coin_dedector/core/enums.dart';
import 'package:automated_coin_dedector/ui/home_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    var boolStreamProvider =
        Provider.of<BoolStreamProvider>(context, listen: false);
    boolStreamProvider.initBoolStream();

    super.initState();
  }

  @override
  void dispose() {
    var boolStreamProvider = Provider.of<BoolStreamProvider>(context);
    boolStreamProvider.myStream.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var boolStreamProvider = Provider.of<BoolStreamProvider>(context);
    List<CardModel> list = [];
    return Scaffold(
        appBar: AppBar(
          title: StreamBuilder<CardModel>(
            initialData:
                CardModel(bString: BoolString.Real, time: DateTime.now()),
            stream: boolStreamProvider.myStream,
            builder: (context, snapshot) {
              return Text(snapshot.data!.bString.name);
            },
          ),
          leading: IconButton(
            icon: boolStreamProvider.shouldEmit == true
                ? Icon(Icons.pause)
                : Icon(Icons.play_arrow),
            onPressed: () {
              boolStreamProvider.shouldEmit == true
                  ? boolStreamProvider.pause()
                  : boolStreamProvider.resume();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: StreamBuilder<CardModel>(
            initialData:
                CardModel(bString: BoolString.Real, time: DateTime.now()),
            stream: boolStreamProvider.myStream,
            builder: (context, snapshot) {
              list.add(CardModel(
                  bString: snapshot.data!.bString, time: snapshot.data!.time));

              return ListView.builder(
                  itemCount: list.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return ExpandableTile(model: list[index]);
                  });
            },
          )),
        ));
  }
}
