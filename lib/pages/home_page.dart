import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:excuse_generator/models/excuse.dart';
import 'package:excuse_generator/pages/create_excuse_page.dart';
import 'package:excuse_generator/pages/favorites_page.dart';
import 'package:excuse_generator/pages/history_page.dart';
import 'package:excuse_generator/pages/stats_page.dart';
import 'package:excuse_generator/services/excuse_service.dart';
import 'package:excuse_generator/widgets/category_card.dart';
import 'package:excuse_generator/widgets/excuse_card.dart';
import 'package:excuse_generator/widgets/rating_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All';
  late Excuse _currentExcuse;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final excuseService = Provider.of<ExcuseService>(context, listen: false);
      setState(() {
        _currentExcuse = excuseService.generateExcuse();
      });
    });
  }

  void _generateNewExcuse() {
    final excuseService = Provider.of<ExcuseService>(context, listen: false);
    setState(() {
      _currentExcuse = _selectedCategory == 'All'
          ? excuseService.generateExcuse()
          : excuseService.generateExcuse(category: _selectedCategory);
    });
  }

  void _toggleFavorite() {
    final excuseService = Provider.of<ExcuseService>(context, listen: false);
    excuseService.toggleFavorite(_currentExcuse);
    setState(() {});
  }

  void _rateExcuse() {
    showDialog(
      context: context,
      builder: (context) => RatingDialog(
        excuse: _currentExcuse,
        onRatingSubmitted: (rating) {
          Provider.of<ExcuseService>(context, listen: false)
              .updateExcuseRating(_currentExcuse.id, rating);
        },
      ),
    );
  }

  void _shareExcuse() {
    Share.share(
      'Check out this excuse: "${_currentExcuse.text}"\n\nGenerated by Excuse Generator App',
    );
  }

  @override
  Widget build(BuildContext context) {
    final excuseService = Provider.of<ExcuseService>(context);
    final isFavorite =
        excuseService.getFavorites().any((e) => e.id == _currentExcuse.id);

    // Define all pages here instead of using a separate widget
    final List<Widget> _pages = [
      // Home Page Content
      SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Need an excuse?',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Select a category and generate your perfect excuse',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryCard(
                    category: 'All',
                    isSelected: _selectedCategory == 'All',
                    onTap: () {
                      setState(() {
                        _selectedCategory = 'All';
                      });
                    },
                  ),
                  ...excuseService.categories.map(
                    (category) => CategoryCard(
                      category: category,
                      isSelected: _selectedCategory == category,
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ExcuseCard(
              excuse: _currentExcuse,
              isFavorite: isFavorite,
              onRate: _rateExcuse,
              onGenerateNew: _generateNewExcuse,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _generateNewExcuse,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Generate New Excuse',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _toggleFavorite,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isFavorite
                          ? Colors.red
                          : Theme.of(context).colorScheme.primary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    label: Text(
                      isFavorite ? 'Saved' : 'Save',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _shareExcuse,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.share),
                    label: Text(
                      'Share',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // History Page
      const HistoryPage(),
      // Stats Page
      const StatsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Excuse Generator',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoritesPage(favorites: excuseService.getFavorites()),
                ),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateExcusePage()),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Create Excuse'),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}
