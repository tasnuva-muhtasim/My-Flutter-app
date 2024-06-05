import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile_model.dart';

class SocialMediaLinks extends StatelessWidget {
  final TextEditingController _linkController = TextEditingController();
  
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
                Text('Social Media Links', style: Theme.of(context).textTheme.headlineSmall),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: profileModel.socialMediaLinks.length,
                  itemBuilder: (context, index) {
                    final link = profileModel.socialMediaLinks[index];
                    return ListTile(
                      title: Text(link),
                    );
                  },
                ),
                TextField(
                  controller: _linkController,
                  decoration: InputDecoration(labelText: 'Add Social Media Link'),
                ),
                ElevatedButton(
                  onPressed: () {
                    profileModel.addSocialMediaLink(_linkController.text);
                    _linkController.clear();
                  },
                  child: Text('Add Link'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
