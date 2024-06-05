import 'package:flutter/material.dart';

class ProfileModel extends ChangeNotifier {
  String name = '';
  String bio = '';
  String contact = '';
  String photoUrl = '';
  String resumeUrl = '';
  List<String> socialMediaLinks = [];
  List<PortfolioItem> portfolioItems = [];
  List<BlogPost> blogPosts = [];
  List<Achievement> achievements = [];

  void updateProfile({String? newName, String? newBio, String? newContact, String? newPhotoUrl, String? newResumeUrl}) {
    if (newName != null) name = newName;
    if (newBio != null) bio = newBio;
    if (newContact != null) contact = newContact;
    if (newPhotoUrl != null) photoUrl = newPhotoUrl;
    if (newResumeUrl != null) resumeUrl = newResumeUrl;
    notifyListeners();
  }

  void addSocialMediaLink(String link) {
    socialMediaLinks.add(link);
    notifyListeners();
  }

  void addPortfolioItem(PortfolioItem item) {
    portfolioItems.add(item);
    notifyListeners();
  }

  void addBlogPost(BlogPost post) {
    blogPosts.add(post);
    notifyListeners();
  }

  void addAchievement(Achievement achievement) {
    achievements.add(achievement);
    notifyListeners();
  }
}

class PortfolioItem {
  final String title;
  final String description;
  final String link;

  PortfolioItem({required this.title, required this.description, required this.link});
}

class BlogPost {
  final String title;
  final String content;

  BlogPost({required this.title, required this.content});
}

class Achievement {
  final String title;
  final String date;

  Achievement({required this.title, required this.date});
}
