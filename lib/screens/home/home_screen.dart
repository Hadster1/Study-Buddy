import 'package:flutter/material.dart';
import '../../components/section_title.dart';
import '../../constants.dart';
import '../../screens/filter/filter_screen.dart';
import '../class_details/class_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: Column(
          children: [
            Text(
              "Study Buddy".toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: primaryColor),
            ),
            const Text(
              "Welcome Back --NAME--!",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: "Classes", press: () {}),
              const SizedBox(height: 16),

              // Demo list of classes (You can replace it with real data)
              ...List.generate(
                4,  // For demo we use 4 items
                (index) => Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultPadding, 0, defaultPadding, defaultPadding),
                  child: ClassInfoBigCard(
                    classCode: "COMPSCI ----",  // You can use actual class codes
                    className: "Intro to COMPSCI",
                    classRoom: "Room 101",
                    professor: "Dr. Prof Name",
                    schedule: "Sun, Tues, Thurs 10:00 AM - 11:30 AM",
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailsScreen(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCourseDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
    );
  }

    // Method to show dialog for adding a new course
    void _showAddCourseDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String courseCode = '';
    String courseName = '';
    String professor = '';
    String room = '';
    String schedule = '';
    DateTime? homeworkDue;
    DateTime? midtermDate;
    DateTime? finalExamDate;
    List<String> selectedDays = [];
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Builder(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
                child: SingleChildScrollView( // Wrap the entire dialog in a scrollable view
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add New Course', style: TextStyle(color: Colors.black, fontSize: 18)),
                      const SizedBox(height: 16),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Course Code'),
                              onSaved: (value) {
                                courseCode = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the course code';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Course Name'),
                              onSaved: (value) {
                                courseName = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the course name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Professor'),
                              onSaved: (value) {
                                professor = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Room'),
                              onSaved: (value) {
                                room = value!;
                              },
                            ),
                            const SizedBox(height: 16),
                        
                            // Days Selection with Checkboxes
                            const Text('Select Days'),
                            Column(
                              children: List.generate(
                                7, // 7 days of the week
                                (index) {
                                  final days = [
                                    'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
                                  ];
                                  return CheckboxListTile(
                                    title: Text(days[index]),
                                    value: selectedDays.contains(days[index]),
                                    onChanged: (bool? value) {
                                      if (value != null) {
                                        if (value) {
                                          selectedDays.add(days[index]);
                                        } else {
                                          selectedDays.remove(days[index]);
                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                        
                            // Time Picker to select class time
                            Row(
                              children: [
                                const Text('Class Time: '),
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: selectedTime,
                                    );
                                    if (pickedTime != null && pickedTime != selectedTime) {
                                      selectedTime = pickedTime;
                                    }
                                  },
                                  child: Text(
                                    selectedTime.format(context), // Display selected time
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                        
                            // Homework Due Date
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Homework Due Date'),
                              onTap: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  homeworkDue = pickedDate;
                                }
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                text: homeworkDue != null ? homeworkDue!.toLocal().toString() : '',
                              ),
                            ),
                            // Midterm Date
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Midterm Date'),
                              onTap: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  midtermDate = pickedDate;
                                }
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                text: midtermDate != null ? midtermDate!.toLocal().toString() : '',
                              ),
                            ),
                            // Final Exam Date
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Final Exam Date'),
                              onTap: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  finalExamDate = pickedDate;
                                }
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                text: finalExamDate != null ? finalExamDate!.toLocal().toString() : '',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // You can now save the course details and update the UI
                                // For example, saving the course data to a list or database
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ClassInfoBigCard extends StatelessWidget {
  final String classCode;
  final String className;
  final String classRoom;
  final String professor;
  final String schedule;
  final VoidCallback press;

  const ClassInfoBigCard({
    Key? key,
    required this.classCode,
    required this.className,
    required this.classRoom,
    required this.professor,
    required this.schedule,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                classCode,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                className,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    classRoom,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    professor,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    schedule,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
