import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  bool isPomodoro = true; // Start with Pomodoro timer
  int pomodoroTime = 25 * 60; // 25 minutes in seconds
  int breakTime = 5 * 60; // 5 minutes break in seconds
  late int currentTime;

  @override
  void initState() {
    super.initState();
    // Initialize currentTime with pomodoroTime when the widget is created.
    currentTime = pomodoroTime; 
  }

  void toggleTimer() {
    setState(() {
      // Toggle between Pomodoro and Break timer
      isPomodoro = !isPomodoro;
      currentTime = isPomodoro ? pomodoroTime : breakTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(isPomodoro ? 'Pomodoro Timer' : 'Break Time'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: toggleTimer,
          ),
        ],
      ),
      body: Center(
        child: Countdown(
          seconds: currentTime,
          build: (BuildContext context, double time) {
            // Format time as mm:ss
            int minutes = (time / 60).floor();
            int seconds = (time % 60).toInt();
            return Text(
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            );
          },
          interval: Duration(seconds: 1),
          onFinished: () {
            // When the timer finishes, toggle between Pomodoro and Break
            toggleTimer();
            // Optionally show a message or perform any action when the timer ends
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(isPomodoro ? 'Study Time Starts!' : 'Break Time Starts!'),
              ),
            );
          },
        ),
      ),
    );
  }
}
