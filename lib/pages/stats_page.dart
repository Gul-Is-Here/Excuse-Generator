import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:excuse_generator/services/excuse_service.dart';

import '../models/excuse.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final excuseService = Provider.of<ExcuseService>(context);
    final history = excuseService.getHistory();
    final favorites = excuseService.getFavorites();
    final customExcuses = excuseService.getCustomExcuses();

    return Scaffold(
      appBar:  AppBar(
        title: Text('Your Excuse Statistics'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildStatCard(
            'Total Excuses Generated',
            history.length.toString(),
            Icons.format_list_numbered,
          ),
          _buildStatCard(
            'Favorite Excuses',
            favorites.length.toString(),
            Icons.favorite,
          ),
          _buildStatCard(
            'Custom Excuses Created',
            customExcuses.length.toString(),
            Icons.create,
          ),
          const SizedBox(height: 24),
          const Text(
            'Excuse Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildCategoryList(history),
          const SizedBox(height: 24),
          const Text(
            'Excuse Ratings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildRatingList(excuseService),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  value,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(List<Excuse> history) {
    final categoryCounts = <String, int>{};
    for (final excuse in history) {
      categoryCounts[excuse.category] = (categoryCounts[excuse.category] ?? 0) + 1;
    }

    return Column(
      children: categoryCounts.entries.map((entry) => ListTile(
        title: Text(entry.key),
        trailing: Text(entry.value.toString()),
      )).toList(),
    );
  }

  Widget _buildRatingList(ExcuseService service) {
    final excuses = [...service.getHistory(), ...service.getCustomExcuses()];
    final ratingCounts = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (final excuse in excuses) {
      if (excuse.rating > 0) {
        final starRating = excuse.rating.round();
        ratingCounts[starRating] = (ratingCounts[starRating] ?? 0) + 1;
      }
    }

    return Column(
      children: ratingCounts.entries.map((entry) => ListTile(
        leading: Text('${entry.key} Star${entry.key > 1 ? 's' : ''}'),
        trailing: Text(entry.value.toString()),
      )).toList(),
    );
  }
}