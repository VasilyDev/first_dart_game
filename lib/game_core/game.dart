// ignore_for_file: prefer_const_constructors
import 'dart:isolate';
import 'package:first_dart_game/game_core/main_loop.dart';
import 'package:first_dart_game/utilits/commons_vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  double x = 100;
  double y = 200;

  late ReceivePort _receivePort;
  late Isolate isolateLoop;

//инициализируем порт и изолят
  void startIsolateLoop() async {
    _receivePort = ReceivePort();
    isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);
// чтобы получать данные из нашего луп изолята мы создаем ресив порт и вешаем на него слушателя,
//который будет ждать инфо от сендпорта из нашего лупизолята
    _receivePort.listen((message) {
      setState(() {});
      x++;
      if (x >= 500) {
        x = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstStartGame) {
      startIsolateLoop();
      isFirstStartGame = false;
    }

    return Stack(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Positioned(
          top: y,
          left: x,
          child: Text('Play'),
        ),
      ],
    );
  }
}
