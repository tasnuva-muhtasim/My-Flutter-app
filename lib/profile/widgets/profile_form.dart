import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile_model.dart';

class ProfileForm extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  
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
                Text('Personal Information', style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person)),
                  onChanged: (value) {
                    profileModel.updateProfile(newName: value);
                  },
                ),
                TextField(
                  controller: _bioController,
                  decoration: InputDecoration(labelText: 'Bio', prefixIcon: Icon(Icons.info)),
                  onChanged: (value) {
                    profileModel.updateProfile(newBio: value);
                  },
                ),
                TextField(
                  controller: _contactController,
                  decoration: InputDecoration(labelText: 'Contact', prefixIcon: Icon(Icons.phone)),
                  onChanged: (value) {
                    profileModel.updateProfile(newContact: value);
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Functionality to upload and set photo and resume URL
                  },
                  child: Text('Upload Photo & Resume'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
