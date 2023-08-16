import 'package:flutter/material.dart';
import 'package:green_cleats/utils/colors.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Get in touch with us',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 16.0),
            Text(
              'Have a question or feedback about Green Cleats? We would love to hear from you! You can reach us using any of the following methods:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 32.0),
            Text(
              'Email',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 8.0),
            InkWell(
              onTap: () {},
              child: Text(
                'contact@greencleats.com',
                style: TextStyle(
                  color: AppColors.animationGreenColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Phone',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 8.0),
            InkWell(
              onTap: () {},
              child: Text(
                '+92 (21) 123-45678',
                style: TextStyle(
                  color: AppColors.animationGreenColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Social Media',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.facebook),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.app_shortcut),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.app_shortcut),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
