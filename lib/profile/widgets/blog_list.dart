import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile_model.dart';

class BlogList extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  
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
                Text('Blog', style: Theme.of(context).textTheme.headlineSmall),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: profileModel.blogPosts.length,
                  itemBuilder: (context, index) {
                    final post = profileModel.blogPosts[index];
                    return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.content),
                    );
                  },
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Blog Title'),
                ),
                TextField(
                  controller: _contentController,
                  decoration: InputDecoration(labelText: 'Blog Content'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final post = BlogPost(
                      title: _titleController.text,
                      content: _contentController.text,
                    );
                    profileModel.addBlogPost(post);
                    _titleController.clear();
                    _contentController.clear();
                  },
                  child: Text('Add Blog Post'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
