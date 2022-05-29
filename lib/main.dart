import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
//этот метод настраивает правильную визуализацию наших виджетов
  WidgetsFlutterBinding.ensureInitialized();

//Прописываем горизонтальную ориентацию у приложения =>
//добавляем whenComplete, пока не выполниться эта функция не начнется runApp
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .whenComplete(() => {
//убираем верхнюю строку
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]),

            runApp(MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Center(
                child: Text("Game"),
              ),
            )),
          });
}
