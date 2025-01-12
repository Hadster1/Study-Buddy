import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'package:flutter_cohere/flutter_cohere.dart';

const String cohereApiKey = 'A2I0yLDFFfRXQedOxN6xkor3mQkIH1SIYh7Twd1V'; 


const String geminiApiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyC7-WRAIvBt-m8dGAR_9ifboHGoWfw9MSo';  // Placeholder URL
const String apiKey = 'AIzaSyD_aIsfF0GxOCVKMjD8dYhHSslcd56qG20';  // Replace with your Gemini API key

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final Gemini gemini = Gemini.instance;

  // Hidden message providing context to the AI
  String _hiddenContext = """
      You are an AI Study Assistant helping the user manage their study schedule, class-related events, assignments, and other academic-related tasks.
      Your role is to answer questions about their calendar, upcoming assignments, and provide study-related assistance. For testing purposes, here is a 
      sample data i want you to use to reply to the user. 
      {
        "student": "John Doe",
        "schedule": [
          {
            "date": "2023-03-04",
            "events": [
              {
                "time": "09:00 AM - 11:00 AM",
                "event": "Data Structures and Algorithms class"
              },
              {
                "time": "11:00 AM - 12:00 PM",
                "event": "Study session for Data Structures assignment"
              },
              {
                "time": "03:00 PM - 05:00 PM",
                "event": "Complete Discrete Mathematics homework on set theory"
              }
            ]
          },
          {
            "date": "2023-03-05",
            "events": [
              {
                "time": "01:00 PM - 03:00 PM",
                "event": "Discrete Mathematics class"
              },
              {
                "time": "03:00 PM - 04:00 PM",
                "event": "Review notes for Discrete Mathematics quiz (March 14th)"
              },
              {
                "time": "Evening",
                "event": "Study group meeting for Software Engineering project"
              }
            ]
          },
          {
            "date": "2023-03-06",
            "events": [
              {
                "time": "09:00 AM - 11:00 AM",
                "event": "Data Structures and Algorithms class"
              },
              {
                "time": "01:00 PM - 03:00 PM",
                "event": "Work on Data Structures assignment (due March 10th)"
              },
              {
                "time": "Evening",
                "event": "Plan and organize for Software Engineering team project meeting"
              }
            ]
          },
          {
            "date": "2023-03-07",
            "events": [
              {
                "time": "10:00 AM - 12:00 PM",
                "event": "Software Engineering class"
              },
              {
                "time": "12:00 PM - 02:00 PM",
                "event": "Work on Software Engineering project (due April 5th)"
              },
              {
                "time": "Evening",
                "event": "Prepare for midterm exams (Computer Networks, Operating Systems)"
              }
            ]
          }
        ],
        "assignments": [
          {
            "name": "Data Structures Assignment",
            "due_date": "2023-03-10",
            "description": "Implement a sorting algorithm for a data structure problem."
          },
          {
            "name": "Discrete Mathematics Quiz",
            "due_date": "2023-03-14",
            "description": "Covering set theory and logic."
          },
          {
            "name": "Software Engineering Final Project",
            "due_date": "2023-04-05",
            "description": "Develop a small web application with a team."
          }
        ],
        "midterms": [
          {
            "name": "Computer Networks",
            "date": "2023-03-27",
            "description": "Midterm covering networking protocols and concepts."
          },
          {
            "name": "Operating Systems",
            "date": "2023-03-29",
            "description": "Midterm covering OS principles, scheduling, and memory management."
          }
        ],
        "extracurriculars": [
          {
            "name": "Coding Competition",
            "date": "2023-03-23",
            "time": "All day",
            "description": "Participate in the university's annual coding competition."
          }
        ]
      }
    """;

  @override
  void initState() {
    super.initState();
    // Send an initial greeting message
    _sendInitialMessage();
  }

  // Function to send the initial message
  void _sendInitialMessage() {
    setState(() {
      _messages.add({
        "message": "Hi! I'm your personal AI Study Buddy. 😊\n\n"
            "I will help you manage your classes, schedule, calendar, and more.\n\n"
            "You can ask me questions like, 'What's my next event on my calendar?' or 'What are my upcoming assignments?'.\n\n"
            "Let's get started! Feel free to ask me anything.",
        "isUser": false,
      });
    });
  }

  // Function to update the hidden context
  void _updateHiddenContext(String newContext) {
    setState(() {
      _hiddenContext += "\n$newContext";
    });
  }

  // Function to send messages to the chatbot
  void _sendMessage(String message) {
    setState(() {
      _messages.add({"message": "You: $message", "isUser": true});
    });

    // Combine the hidden context and the user's message
    String fullMessage = "$_hiddenContext\n$message";

    gemini.chat([
      Content(parts: [Part.text(fullMessage)], role: 'user'),
    ]).then((response) {
      setState(() {
        _messages.add({
          "message": response?.output ?? "No response",
          "isUser": false,
          "image": "../../../assets/Illustrations/ai-mi-algorithm-svgrepo-com.svg"
        });
      });
    }).catchError((e) {
      setState(() {
        _messages.add({"message": "Error: $e", "isUser": false});
      });
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Study Assistant"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask a question...",
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
          ],
        ),
      ),
    );
  }
}
