import 'package:flutter/material.dart';
import 'dart:async';

import 'package:workout_manager/src/constants/app_styles.dart';

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    required this.hundreds,
    required this.seconds,
    required this.minutes,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners =
      <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle =
      const TextStyle(fontSize: 80.0, fontFamily: "Bebas Neue");
  final Stopwatch stopwatch = Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class TimerPage extends StatefulWidget {
  TimerPage({super.key});

  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  final Dependencies dependencies = Dependencies();
  final List<String> lapList = [];
  void lapButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        final int milliseconds = dependencies.stopwatch.elapsedMilliseconds;
        final int hundreds = ((milliseconds / 10)).truncate();
        final int seconds = (hundreds / 100).truncate();
        final int minutes = (seconds / 60).truncate();
        final String lapString =
            "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${(hundreds % 100).toString().padLeft(2, '0')}";
        lapList.add(lapString);
      }
    });
  }

  void resetButtonPressed() {
    setState(() {
      dependencies.stopwatch.reset();
      lapList.clear();
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      }
    });
  }

  void playPausePressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      } else {
        dependencies.stopwatch.start();
      }
    });
  }

  Widget buildButton(
      IconData icon, Color color, VoidCallback callback, bool visible) {
    return Visibility(
        visible: visible,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: IconButton(
          color: color,
          onPressed: callback,
          icon: Icon(icon),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: TimerText(dependencies: dependencies),
        ),
        Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: lapList.length,
          itemBuilder: (context, index) {
            return Text(
              lapList[index],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            );
          },
        )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (dependencies.stopwatch.elapsedMilliseconds > 0)
                  buildButton(Icons.restart_alt_rounded, Palette.blue,
                      resetButtonPressed, true)
                else
                  buildButton(Icons.restart_alt_rounded, Palette.blue,
                      resetButtonPressed, false),
                FloatingActionButton.large(
                  heroTag: UniqueKey(),
                  shape: CircleBorder(),
                  backgroundColor: Palette.blue,
                  onPressed: playPausePressed,
                  child: Icon(
                    dependencies.stopwatch.isRunning
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Palette.white,
                  ),
                ),
                if (dependencies.stopwatch.isRunning)
                  buildButton(Icons.more_time_rounded, Palette.blue,
                      lapButtonPressed, true)
                else
                  buildButton(Icons.more_time_rounded, Palette.blue,
                      lapButtonPressed, false)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimerText extends StatefulWidget {
  TimerText({required this.dependencies});
  final Dependencies dependencies;

  @override
  State<TimerText> createState() => TimerTextState();
}

class TimerTextState extends State<TimerText> {
  Timer? timer;
  int milliseconds = 0;

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(
            milliseconds: widget.dependencies.timerMillisecondsRefreshRate),
        callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != widget.dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = widget.dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final ElapsedTime elapsedTime = ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
      );
      for (final listener in widget.dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RepaintBoundary(
          child: SizedBox(
            height: 72.0,
            child: MinutesAndSeconds(dependencies: widget.dependencies),
          ),
        ),
        RepaintBoundary(
          child: SizedBox(
            height: 72.0,
            child: Hundreds(dependencies: widget.dependencies),
          ),
        ),
      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  final Dependencies dependencies;

  const MinutesAndSeconds({super.key, required this.dependencies});

  @override
  State<MinutesAndSeconds> createState() => MinutesAndSecondsState();
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    widget.dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Text('$minutesStr:$secondsStr.',
            style: widget.dependencies.textStyle));
  }
}

class Hundreds extends StatefulWidget {
  final Dependencies dependencies;
  const Hundreds({super.key, required this.dependencies});

  @override
  State<Hundreds> createState() => HundredsState();
}

class HundredsState extends State<Hundreds> {
  int hundreds = 0;

  @override
  void initState() {
    widget.dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(hundredsStr, style: widget.dependencies.textStyle));
  }
}
