import 'package:flutter/material.dart';
import 'package:excuse_generator/models/excuse.dart';
import 'package:intl/intl.dart';

class ExcuseHistoryItem extends StatelessWidget {
  final Excuse excuse;

  const ExcuseHistoryItem({super.key, required this.excuse});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              excuse.text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(excuse.category),
                ),
                Text(
                  DateFormat('MMM d, y - h:mm a').format(excuse.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}