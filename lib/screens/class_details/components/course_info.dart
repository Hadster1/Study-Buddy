import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/price_range_and_food_type.dart';
import '../../../components/rating_with_counter.dart';
import '../../../constants.dart';

class ClassInfo extends StatelessWidget {
  const ClassInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Code and Name
          Text(
            "COMPSCI ----",
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 1,
          ),
          const SizedBox(height: defaultPadding / 2),
          Text(
            "Introduction to Computer Science",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
            maxLines: 1,
          ),
          const SizedBox(height: defaultPadding),

          // Instructor Name
          Text(
            "Instructor: Dr. Prof Name",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
            maxLines: 1,
          ),
          const SizedBox(height: defaultPadding / 2),

          // Class Days and Timings
          Row(
            children: [
              Icon(Icons.access_time, size: 18), // Clock Icon
              const SizedBox(width: 8),
              Text(
                "Mon, Wed, Fri - 10:00 AM - 12:00 PM",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding / 2),

          // Classroom/Room Info
          Row(
            children: [
              Icon(Icons.location_on, size: 18), // Location Icon
              const SizedBox(width: 8),
              Text(
                "Room: B101",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding / 2),

        ],
      ),
    );
  }
}

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({
    super.key,
    required this.iconSrc,
    required this.text,
    required this.subText,
  });

  final String iconSrc, text, subText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
          colorFilter: const ColorFilter.mode(
            primaryColor,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text.rich(
          TextSpan(
            text: "$text\n",
            style: Theme.of(context).textTheme.labelLarge,
            children: [
              TextSpan(
                text: subText,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ],
    );
  }
}
