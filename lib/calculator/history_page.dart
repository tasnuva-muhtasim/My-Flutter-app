import 'package:flutter/material.dart';
import 'history_model.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Consumer<HistoryModel>(
        builder: (context, history, child) {
          return ListView.builder(
            itemCount: history.calculations.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(history.calculations[index]),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<HistoryModel>(context, listen: false).clearHistory();
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
