import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:excuse_generator/services/excuse_service.dart';
import 'package:excuse_generator/widgets/excuse_history_item.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = Provider.of<ExcuseService>(context).getHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Excuse History'),
      ),
      body: history.isEmpty
          ? const Center(
        child: Text('No history yet'),
      )
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ExcuseHistoryItem(excuse: history[index]);
        },
      ),
    );
  }
}