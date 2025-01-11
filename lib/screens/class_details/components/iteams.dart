import 'package:flutter/material.dart';
import '../../../components/cards/iteam_card.dart';
import '../../../constants.dart';
import '../../addToOrder/add_to_order_screen.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTabController(
          length: demoTabs.length,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                unselectedLabelColor: titleColor,
                labelStyle: Theme.of(context).textTheme.titleLarge,
                onTap: (value) {
                  // you will get selected tab index
                },
                tabs: demoTabs,
              ),
              const SizedBox(height: defaultPadding),
              const SizedBox(
                height: 400, // Adjust height as needed
                child: TabBarView(
                  children: [
                    Center(child: Text("AI Study Buddy (brAIny)")),
                    Center(child: Text("Feynman Technique")),
                    Center(child: Text("Flashcards")),
                    Center(child: Text("Pomodoro Timer")),
                    Center(child: Text("Loiter")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final List<Tab> demoTabs = <Tab>[
  const Tab(
    child: Text('AI Study Buddy'),
  ),
  const Tab(
    child: Text('Feynman Technique'),
  ),
  const Tab(
    child: Text('Flashcards'),
  ),
  const Tab(
    child: Text('Pomodoro Timer'),
  ),
  const Tab(
    child: Text('Loiter'),
  ),
];