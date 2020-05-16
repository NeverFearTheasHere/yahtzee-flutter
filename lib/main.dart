import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahtzee/models/DieModel.dart';

import 'models/GameModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yahtzee',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Yahtzee'),
          backgroundColor: Colors.pink,
        ),
        body: ChangeNotifierProvider(
          create: (context) => GameModel(),
          child: Column(
            children: <Widget>[
              Dice(),
              Consumer<GameModel>(
                  builder: (context, game, child) {
                    return RaisedButton(
                      onPressed: game.rollAllUnselectedDice,
                      child: child,
                    );
                  },
                  child: Text('Roll dice')),
            ],
          ),
        ));
  }
}

class Dice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Consumer<GameModel>(builder: (context, game, child) {
        return Row(
            children: game.dice.map((model) => new Die(model: model)).toList());
      }),
    );
  }
}

class Die extends StatelessWidget {
  final DieModel model;

  Die({this.model});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () => model.toggleSelected(),
          child: Container(
            color: model.isSelectedToKeep ? Colors.blue : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset('assets/die-${model.value}.png'),
            ),
          ),
        ),
      ),
    );
  }
}
