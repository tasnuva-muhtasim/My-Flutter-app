import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile_model.dart';

class PortfolioList extends StatelessWidget {
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
                Text('Portfolio', style: Theme.of(context).textTheme.headlineSmall),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: profileModel.portfolioItems.length,
                  itemBuilder: (context, index) {
                    final item = profileModel.portfolioItems[index];
                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.description),
                      onTap: () {
                        // Handle link opening
                      },
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Functionality to add new portfolio item
                  },
                  child: Text('Add Portfolio Item'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
