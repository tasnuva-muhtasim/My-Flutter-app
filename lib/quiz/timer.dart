import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget {
  static void startTimer(BuildContext context, Function onTimerEnd, Function updateRemainingTime) {
    const oneSec = Duration(seconds: 1);
    int _start = 60; // 60 seconds for the quiz

    Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        timer.cancel();
        onTimerEnd();
      } else {
        _start--;
        updateRemainingTime(_start);
      }
    });
  }
}
