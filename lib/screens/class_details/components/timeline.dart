import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date formatting
import '../../../constants.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  bool _showFurtherAhead = false; // Track if the "Show further ahead" button is pressed

  @override
  Widget build(BuildContext context) {
    // Filter events to only show those within 2 weeks
    final upcomingEvents = events.where((event) {
      final daysRemaining = _getDaysRemaining(event['date']);
      return daysRemaining >= 0 && daysRemaining <= 14;
    }).toList();

    // Separate events into upcoming and further events
    final furtherEvents = events.where((event) {
      final daysRemaining = _getDaysRemaining(event['date']);
      return daysRemaining > 14;
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: Text(
              "Timeline",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          
          // Display upcoming events
          ...List.generate(upcomingEvents.length, (index) {
            final event = upcomingEvents[index];
            final daysRemaining = _getDaysRemaining(event['date']);
            return Padding(
              padding: const EdgeInsets.only(bottom: defaultPadding),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: index % 2 == 0 ? Colors.blue : Colors.orange, // Different color for visual distinction
                    size: 10,
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['title'],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        DateFormat('MMMM dd, yyyy').format(event['date']),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$daysRemaining days remaining",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),

          // Show the "Show further ahead" button if there are any further events
          if (furtherEvents.isNotEmpty) ...[
            GestureDetector(
              onTap: () {
                setState(() {
                  _showFurtherAhead = !_showFurtherAhead;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.center,
                child: Text(
                  _showFurtherAhead ? "Show less" : "Show further ahead",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // Gradient fade and display further events
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: _showFurtherAhead
                    ? null
                    : LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
              ),
              child: Column(
                children: [
                  // Only show further events when the button is pressed
                  if (_showFurtherAhead) ...[
                    ...List.generate(furtherEvents.length, (index) {
                      final event = furtherEvents[index];
                      final daysRemaining = _getDaysRemaining(event['date']);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: defaultPadding),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: index % 2 == 0 ? Colors.blue : Colors.orange, // Different color for visual distinction
                              size: 10,
                            ),
                            const SizedBox(width: defaultPadding / 2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event['title'],
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  DateFormat('MMMM dd, yyyy').format(event['date']),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "$daysRemaining days remaining",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Method to calculate days remaining from today
  int _getDaysRemaining(DateTime eventDate) {
    final today = DateTime.now();
    return eventDate.difference(today).inDays;
  }
}

// List of events to display in the timeline
final List<Map<String, dynamic>> events = [
  {
    "title": "Homework due",
    "date": DateTime(2025, 1, 15),
  },
  {
    "title": "Exam",
    "date": DateTime(2025, 2, 14),
  },
  {
    "title": "Homework due",
    "date": DateTime(2025, 2, 28),
  },
  {
    "title": "Assignment submission",
    "date": DateTime(2025, 3, 5),
  },
  {
    "title": "Final Exam",
    "date": DateTime(2025, 4, 1),
  },
  // Add more events here as needed
];
