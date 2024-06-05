import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about_model.dart';

class AboutPage extends StatelessWidget {
  final AboutModel aboutModel = AboutModel();

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Tasnuva Muhtasim'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(aboutModel.photoUrl),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  aboutModel.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  aboutModel.bio,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              _buildSectionTitle(context, 'Education'),
              Text(
                aboutModel.education,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 20),
              Divider(),
              _buildSectionTitle(context, 'Work Experience'),
              Text(
                aboutModel.workExperience,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 20),
              Divider(),
              _buildSectionTitle(context, 'Projects'),
              Text(
                aboutModel.projects,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 20),
              Divider(),
              _buildSectionTitle(context, 'Achievements'),
              ...aboutModel.achievements.map((achievement) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('• $achievement', style: Theme.of(context).textTheme.bodyMedium),
                  )),
              SizedBox(height: 20),
              Divider(),
              _buildSectionTitle(context, 'Portfolio Links'),
              ...aboutModel.portfolioLinks.map((link) => ListTile(
                    leading: Icon(Icons.link),
                    title: Text(link),
                    onTap: () => _launchURL(link),
                  )),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
