import 'package:flutter/material.dart';
import 'package:excuse_generator/models/excuse.dart';
import 'package:excuse_generator/widgets/excuse_card.dart';

class FavoritesPage extends StatelessWidget {
  final List<Excuse> favorites;

  const FavoritesPage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Excuses'),
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ExcuseCard(
              excuse: favorites[index],
              isFavorite: true,
            ),
          );
        },
      ),
    );
  }
}