import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [HistoryView] represent the view for player score history
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  // Getting the score from the shared preferences
  Future<List<HistoryModel>> getScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> score = prefs.getStringList('score') ?? [];

    final List<HistoryModel> historyList = score.map((item) => HistoryModel.fromMap(json.decode(item))).toList();

    return historyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your History'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent.shade100.withOpacity(0.1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getScore(),
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Score: ${snapshot.data![index].score}',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Date & Time: ${snapshot.data![index].date}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: snapshot.data!.length,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
