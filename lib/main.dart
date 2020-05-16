import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yahtzee',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Random random = new Random();
  List<int> diceValues = new List.generate(5, (_) => random.nextInt(6) + 1);

  void rollDice() {
    setState(() {
      diceValues = new List.generate(5, (_) => random.nextInt(6) + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yahtzee'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: <Widget>[
          Dice(diceValues: diceValues),
          RaisedButton(
            onPressed: rollDice,
            child: Text('Roll dice'),
          )
        ],
      ),
    );
  }
}

class Dice extends StatelessWidget {
  final List<int> diceValues;

  Dice({Key key, @required this.diceValues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
          children: diceValues
              .map((dieValue) => new Die(dieValue: dieValue))
              .toList()),
    );
  }
}

class Die extends StatelessWidget {
  final int dieValue;

  Die({Key key, @required this.dieValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Image.asset('assets/die-$dieValue.png'),
      ),
    );
  }
}
