import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'beer_file.dart';
import 'models.dart';
import 'network_helper.dart';

class BeerListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Beer List App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.black, accentColor: Colors.black),
        home: Home(),
      );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Beer> _beers = <Beer>[];

  @override
  void initState() {
    super.initState();
    listenForBeers();
  }

  void listenForBeers() async {
    final Stream<Beer> stream = await getBeers();
    stream.listen((Beer beer) => setState(() => _beers.add(beer)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Top Beers'),
      ),
      body: ListView.builder(
        itemCount: _beers.length,
        itemBuilder: (context, index) => BeerTile(_beers[index]),
      ));
}

void main() => runApp(BeerListApp());
