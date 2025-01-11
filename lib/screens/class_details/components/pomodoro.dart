import 'package:flutter/material.dart';
import 'dart:async';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  PomodoroTimerState createState() => PomodoroTimerState();
}

class PomodoroTimerState extends State<PomodoroTimer> {
  static const int workDuration = 2 * 60; // 25 minutes in seconds
  static const int breakDuration = 5 * 60; // 5 minutes in seconds

  late int _remainingTime;
  Timer? _timer;  // Make _timer nullable
  bool _isRunning = false;
  bool _isWorkTime = true;

  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _remainingTime = workDuration;
  }

  void _startTimer() {
    if (_isRunning) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_remainingTime > 0) {
            _remainingTime--;
          } else {
            _isWorkTime = !_isWorkTime;
            _remainingTime = _isWorkTime ? workDuration : breakDuration;
          }
        });
      }
    });

    setState(() {
      _isRunning = true;
      _messages.add({"message": "Timer started!", "isUser": false});
    });
  }

  void _pauseTimer() {
    if (!_isRunning) return;

    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _messages.add({"message": "Timer paused.", "isUser": false});
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isWorkTime = true;
      _remainingTime = workDuration;
      _messages.add({"message": "Timer reset.", "isUser": false});
    });
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _sendMessage(String message) {
    setState(() {
      _messages.add({"message": "You: $message", "isUser": true});
    });

    if (message.toLowerCase() == "start") {
      _startTimer();
    } else if (message.toLowerCase() == "pause") {
      _pauseTimer();
    } else if (message.toLowerCase() == "reset") {
      _resetTimer();
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Timer Display
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message["isUser"] ? Alignment.centerRight : Alignment.centerLeft,
                    child: Card(
                      color: message["isUser"] ? Colors.blue[100] : Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          message["message"],
                          style: TextStyle(
                            color: message["isUser"] ? Colors.black : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Timer Control Buttons
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type 'start', 'pause', or 'reset'",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),

            // Timer Countdown Display
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                _formatTime(_remainingTime),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Safely cancel the timer if it's not null
    super.dispose();
  }
}
