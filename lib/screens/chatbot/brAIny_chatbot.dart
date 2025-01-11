import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const String geminiApiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyC7-WRAIvBt-m8dGAR_9ifboHGoWfw9MSo';  // Placeholder URL
const String apiKey = 'AIzaSyD_aIsfF0GxOCVKMjD8dYhHSslcd56qG20';  // Replace with your Gemini API key

class brAIny_ChatbotScreen extends StatefulWidget {
  const brAIny_ChatbotScreen({super.key});

  @override
  _brAIny_ChatbotScreenState createState() => _brAIny_ChatbotScreenState();
}

class _brAIny_ChatbotScreenState extends State<brAIny_ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final Gemini gemini = Gemini.instance;

  void _sendMessage(String message) {
  setState(() {
    _messages.add({"message": "You: $message", "isUser": true});
  });

  gemini.chat([
    Content(parts: [Part.text(message)], role: 'user'),
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
        title: const Text("Chat With brAIny"),
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