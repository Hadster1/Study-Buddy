import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const String apiKey = 'AIzaSyD_aIsfF0GxOCVKMjD8dYhHSslcd56qG20';  // Replace with your Gemini API key

class Flashcards extends StatefulWidget {
  const Flashcards({super.key});

  @override
  _FlashcardsState createState() => _FlashcardsState();
}

class _FlashcardsState extends State<Flashcards> {
  final PageController _pageController = PageController();
  bool _isFront = true;
  List<Map<String, String>> _flashcards = [];
  final Gemini gemini = Gemini.instance;

  @override
  void initState() {
    super.initState();
    _fetchFlashcards();
  }

  // Function to fetch flashcards from Gemini
  Future<void> _fetchFlashcards() async {
    try {
      // Sending the prompt to Gemini
      final response = await gemini.chat([
        Content(parts: [
          Part.text('Give me a list of terms and definitions for studying for computer science in this format. Do not include any unnecessary instructions as I need that format for parsing correctly.\n____________\nTerm - Definition\nTerm - Definition')
        ], role: 'user'),
      ]);

      // Assuming the response format gives you a list of terms and definitions
      final generatedContent = response?.output ?? 'No flashcards generated';
      
      // Parsing the content into terms and definitions
      final List<Map<String, String>> flashcards = _parseFlashcards(generatedContent);
      
      setState(() {
        _flashcards = flashcards;
      });
    } catch (e) {
      print('Failed to load flashcards: $e');
    }
  }

  // Function to parse the flashcards from the generated content
  List<Map<String, String>> _parseFlashcards(String content) {
    final List<Map<String, String>> flashcards = [];
    final lines = content.split('\n');
    for (var line in lines) {
      if (line.contains(' - ')) {
        final parts = line.split(' - ');
        if (parts.length == 2) {
          flashcards.add({'term': parts[0].trim(), 'definition': parts[1].trim()});
        }
      }
    }
    return flashcards;
  }

  void _flipCard() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _flashcards.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _flashcards.length,
                    itemBuilder: (context, index) {
                      final flashcard = _flashcards[index];
                      return GestureDetector(
                        onTap: _flipCard,
                        child: Card(
                          margin: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              _isFront ? flashcard['term']! : flashcard['definition']!,
                              style: Theme.of(context).textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (_pageController.page! > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.flip),
                      onPressed: _flipCard,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (_pageController.page! < _flashcards.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}