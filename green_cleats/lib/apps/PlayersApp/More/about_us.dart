import 'package:flutter/material.dart';
import 'package:green_cleats/utils/colors.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/about_us_header.jpg',
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Story',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.animationBlueColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Green Cleats was founded in 2023 with the goal of connecting football enthusiasts from all over the world. Our team is made up of passionate football fans who want to create a community where people can share their love for the beautiful game.',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.animationBlueColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Our mission is to provide a platform where football fans can come together to discuss, share and learn about the sport they love. We believe that football has the power to bring people together, and we want to use this power to create positive change in the world.',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Meet Our Team',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.animationBlueColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTeamMember(
                        'Shayan Ali Mankani',
                        'assets/images/team_member_1.jpg',
                      ),
                      _buildTeamMember(
                        'Aadesh Kumar',
                        'assets/images/team_member_2.jpg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(String name, String imageAsset) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.khakiColor,
          backgroundImage: AssetImage(imageAsset),
          radius: 50,
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Co-Founder',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
