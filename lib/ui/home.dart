import 'package:automated_coin_dedector/core/bool_strean_provider.dart';
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

    return Scaffold(
        appBar: AppBar(
          title: StreamBuilder<BoolString>(
            initialData: BoolString.Real,
            stream: boolStreamProvider.myStream,
            builder: (context, snapshot) {
              return Text(snapshot.data!.name);
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
              //child: Text(streamProvider.boolean.toString()),
              child: StreamBuilder<BoolString>(
            initialData: BoolString.Real,
            stream: boolStreamProvider.myStream,
            builder: (context, snapshot) {
              //return Text(snapshot.data.toString());
              return Text(snapshot.data!.name);
            },
          )),
        ));
  }
}
