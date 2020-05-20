import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yahtzee/models/DieModel.dart';

import 'models/GameModel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

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
                      onPressed: game.canRollDice()
                          ? game.rollAllUnselectedDice
                          : null,
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
            children: game.dice
                .map((model) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: new Die(model: model),
                      ),
                    ))
                .toList());
      }),
    );
  }
}

class Die extends StatelessWidget {
  final DieModel model;

  Die({this.model});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => model.toggleSelected(),
        child: Container(
          decoration: new BoxDecoration(
              color: model.isSelectedToKeep ? Colors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset('assets/die-${model.value}.png'),
            ),
          ),
        ),
      ),
    );
  }
}
