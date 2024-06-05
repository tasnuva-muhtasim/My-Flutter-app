import 'package:flutter/material.dart';
import 'package:my_flutter_app/main.dart';
import 'package:provider/provider.dart';
import 'profile_model.dart';
import 'widgets/profile_form.dart';
import 'widgets/portfolio_list.dart';
import 'widgets/social_media_links.dart';
import 'widgets/blog_list.dart';
import 'widgets/achievements_list.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.brightness_6),
              onPressed: () {
                Provider.of<ThemeModel>(context, listen: false).toggleTheme();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileForm(),
                SizedBox(height: 16),
                PortfolioList(),
                SizedBox(height: 16),
                SocialMediaLinks(),
                SizedBox(height: 16),
                BlogList(),
                SizedBox(height: 16),
                AchievementsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
