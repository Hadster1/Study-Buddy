import 'package:flutter/material.dart';
import 'package:study_buddy/screens/class_details/components/course_info.dart';
import '../../constants.dart';
import 'components/featured_items.dart';
import 'components/iteams.dart';
import 'components/timeline.dart';
import '../../providers/course_model.dart';

class DetailsScreen extends StatelessWidget {
  final Course course;

  const DetailsScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          /* IconButton(
            icon: SvgPicture.asset("assets/icons/share.svg"),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg"),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CalendarScreen(),
              ),
            ),
          ),*/
        ],
      ), 
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: defaultPadding / 2),
              ClassInfo(),
              SizedBox(height: defaultPadding),
              FeaturedItems(),
              SizedBox(height: defaultPadding),
              Timeline(),
              SizedBox(height: defaultPadding),
              Items(),
            ],
          ),
        ),
      ),
    );
  }
}
