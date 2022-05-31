//нижнее подчеркивание означает что переменая приватна
import 'dart:isolate';

bool _running = true;

void mainLoop(SendPort sendPort) async {
  final double _fps = 50;
  final double _second = 1000;
  final double _updateTime = _second / _fps;
  double _updates = 0;

//для отсчета времени используем стандартный таймер который есть в дарте
  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  Stopwatch _timerWatch = Stopwatch();
  _timerWatch.start();

//если наш таймер отсчитал 20 милисекунд, то он сбрасывается
  while (_running) {
    if (_loopWatch.elapsedMilliseconds > _updateTime) {
      print(_updates++);
      _loopWatch.reset();
      //как обновили луп, мы отправляем данные в наш глаыный изолят
      sendPort.send(true);
    }
  }

  if (_timerWatch.elapsedMilliseconds > _second) {
    print('${DateTime.now()}, FPS: $_updates');
    _updates = 0;
    _timerWatch.reset();
  }
}

//функция которая останавливает луп
void stopLoop() {
  _running = false;
}
