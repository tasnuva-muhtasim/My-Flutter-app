import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile_model.dart';

class AchievementsList extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ProfileModel>(
          builder: (context, profileModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Achievements', style: Theme.of(context).textTheme.headlineSmall),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: profileModel.achievements.length,
                  itemBuilder: (context, index) {
                    final achievement = profileModel.achievements[index];
                    return ListTile(
                      title: Text(achievement.title),
                      subtitle: Text(achievement.date),
                    );
                  },
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Achievement Title'),
                ),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final achievement = Achievement(
                      title: _titleController.text,
                      date: _dateController.text,
                    );
                    profileModel.addAchievement(achievement);
                    _titleController.clear();
                    _dateController.clear();
                  },
                  child: Text('Add Achievement'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
