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
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<CardModel> list = [];

  @override
  void initState() {
    var boolStreamProvider =
        Provider.of<BoolStreamProvider>(context, listen: false);
    boolStreamProvider.initBoolStream();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {listAdd(
    //   CardModel(bString: BoolString.Real, time: DateTime.now()),
    // );});

    super.initState();
  }

  @override
  void dispose() {
    var boolStreamProvider = Provider.of<BoolStreamProvider>(context);
    boolStreamProvider.myStream.drain();
    super.dispose();
  }

  // void listAdd(CardModel model) {
  //   list.add(model);
  //   listKey.currentState!.insertItem(0);
  //   print(list);
  // }

  @override
  Widget build(BuildContext context) {
    var boolStreamProvider = Provider.of<BoolStreamProvider>(context);

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
              // listAdd(CardModel(
              //     bString: snapshot.data!.bString, time: snapshot.data!.time));
              list.add(CardModel(
                  bString: snapshot.data!.bString, time: snapshot.data!.time));
              if(listKey.currentState != null )listKey.currentState!.insertItem(0);
              print(list);
              return AnimatedList(
                key: listKey,
                reverse: false,
                initialItemCount: list.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                      position: animation.drive(
                          Tween(begin: Offset(2, 0.0), end: Offset(0.0, 0.0))
                              .chain(CurveTween(curve: Curves.elasticInOut))),
                      child: ExpandableTile(model: list[index]));
                },
              );
              // return ListView.builder(
              //     itemCount: list.length,
              //     reverse: true,
              //     itemBuilder: (context, index) {
              //       return ExpandableTile(model: list[index]);
              //     });
            },
          )),
        ));
  }
}
