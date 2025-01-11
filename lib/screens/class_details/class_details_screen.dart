import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodly_ui/screens/class_details/components/course_info.dart';

import '../../constants.dart';
import '../calendar/calendar_screen.dart';
import 'components/featured_items.dart';
import 'components/iteams.dart';
import 'components/course_info.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

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
              Items(),
            ],
          ),
        ),
      ),
    );
  }
}
