import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              // Profile Section (Profile Image, Name, and School)
              Row(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const AssetImage('assets/Illustrations/user.png'), // Use local PNG image
                  ),
                  const SizedBox(width: 16),
                  // Profile Name & School
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Student Name", // Replace with user name
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "School Name", // Replace with user school name
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: titleColor.withOpacity(0.64),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Section Title
              Text(
                "Account Settings",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Edit your profile, change password, etc.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: titleColor.withOpacity(0.64),
                    ),
              ),
              const SizedBox(height: 16),
              
              // Profile Settings Menu
              ProfileMenuCard(
                svgSrc: "assets/icons/profile.svg",
                title: "Profile Information",
                subTitle: "Change your account information",
                press: () {},
              ),
              ProfileMenuCard(
                svgSrc: "assets/icons/lock.svg",
                title: "Change Password",
                subTitle: "Change your password",
                press: () {},
              ),
              ProfileMenuCard(
                svgSrc: "assets/icons/share.svg",
                title: "Refer to Friends",
                subTitle: "Get \$10 for referring friends",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    super.key,
    this.title,
    this.subTitle,
    this.svgSrc,
    this.press,
  });

  final String? title, subTitle, svgSrc;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              SvgPicture.asset(
                svgSrc!,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  titleColor.withOpacity(0.64),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subTitle!,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: titleColor.withOpacity(0.54),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
