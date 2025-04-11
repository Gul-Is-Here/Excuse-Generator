import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:excuse_generator/models/excuse.dart';

class ExcuseService extends ChangeNotifier {
  final List<Excuse> _excuses = [];
  final List<Excuse> _history = [];
  final List<Excuse> _customExcuses = [];
  final List<Excuse> _favorites = [];
  final Uuid _uuid = const Uuid();

  ExcuseService() {
    _initializeDefaultExcuses();
  }

  void _initializeDefaultExcuses() {
    _excuses.addAll([
      Excuse(
          id: _uuid.v4(), text: "My dog ate my homework", category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "I had a sudden family emergency",
          category: "Work"),
      Excuse(id: _uuid.v4(), text: "I missed the bus", category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "There was a power outage at home",
          category: "School"),
      Excuse(
          id: _uuid.v4(), text: "My alarm didn't go off", category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "I had a dentist appointment",
          category: "School"),
      Excuse(id: _uuid.v4(), text: "I wasn’t feeling well", category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "I had to babysit my sibling",
          category: "School"),
      Excuse(
          id: _uuid.v4(), text: "I got stuck in traffic", category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "My homework got deleted by accident",
          category: "School"),
      Excuse(id: _uuid.v4(), text: "I forgot it at home", category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "My internet was down during online class",
          category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "I was helping my parents with something urgent",
          category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "There was a family emergency",
          category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "I was at a doctor’s appointment",
          category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "I had to take care of a sick relative",
          category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "I wasn’t aware of the deadline",
          category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "I submitted to the wrong portal",
          category: "School"),
      Excuse(id: _uuid.v4(), text: "My pet was sick", category: "School"),
      Excuse(id: _uuid.v4(), text: "My phone/laptop died", category: "School"),
      Excuse(
          id: _uuid.v4(),
          text: "I had a sudden family emergency",
          category: "Work"),
      Excuse(id: _uuid.v4(), text: "I was stuck in traffic", category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "I had a medical appointment",
          category: "Work"),
      Excuse(id: _uuid.v4(), text: "My internet was down", category: "Work"),
      Excuse(id: _uuid.v4(), text: "My power was out", category: "Work"),
      Excuse(id: _uuid.v4(), text: "I had a flat tire", category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "I had to take care of my child",
          category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "There was a problem with my transport",
          category: "Work"),
      Excuse(id: _uuid.v4(), text: "I was feeling unwell", category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "I had a personal issue to handle",
          category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "I had a plumbing emergency at home",
          category: "Work"),
      Excuse(id: _uuid.v4(), text: "My alarm didn't go off", category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "There was a delay with public transport",
          category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "I had to attend a court appointment",
          category: "Work"),
      Excuse(
          id: _uuid.v4(), text: "I had a mental health day", category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "I had to assist a family member",
          category: "Work"),
      Excuse(
          id: _uuid.v4(), text: "There was a home emergency", category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "I experienced food poisoning",
          category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "There was an unexpected situation at home",
          category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "I had to deal with urgent paperwork",
          category: "Work"),
      Excuse(
          id: _uuid.v4(),
          text: "Something came up unexpectedly",
          category: "All"),
      Excuse(id: _uuid.v4(), text: "I had a prior commitment", category: "All"),
      Excuse(id: _uuid.v4(), text: "I wasn’t feeling well", category: "All"),
      Excuse(id: _uuid.v4(), text: "There was an emergency", category: "All"),
      Excuse(id: _uuid.v4(), text: "My phone died", category: "All"),
      Excuse(id: _uuid.v4(), text: "I lost track of time", category: "All"),
      Excuse(
          id: _uuid.v4(),
          text: "I was caught up in something",
          category: "All"),
      Excuse(id: _uuid.v4(), text: "I got delayed", category: "All"),
      Excuse(id: _uuid.v4(), text: "I had to help a friend", category: "All"),
      Excuse(id: _uuid.v4(), text: "I completely forgot", category: "All"),
      Excuse(id: _uuid.v4(), text: "I had a family situation", category: "All"),
      Excuse(
          id: _uuid.v4(), text: "I was in a no-signal area", category: "All"),
      Excuse(
          id: _uuid.v4(),
          text: "There was a communication issue",
          category: "All"),
      Excuse(id: _uuid.v4(), text: "I misread the timing", category: "All"),
      Excuse(id: _uuid.v4(), text: "I was double-booked", category: "All"),
      Excuse(
          id: _uuid.v4(), text: "I had a scheduling conflict", category: "All"),
      Excuse(
          id: _uuid.v4(), text: "I didn’t realize the time", category: "All"),
      Excuse(
          id: _uuid.v4(),
          text: "I had to handle a personal matter",
          category: "All"),
      Excuse(
          id: _uuid.v4(),
          text: "There was a last-minute change in plans",
          category: "All"),
      Excuse(
          id: _uuid.v4(),
          text: "I was dealing with something urgent",
          category: "All"),
    ]);
    notifyListeners();
  }

  void updateExcuseRating(String id, double rating) {
    final index = _excuses.indexWhere((e) => e.id == id);
    if (index != -1) {
      _excuses[index] = _excuses[index].copyWith(rating: rating);
      notifyListeners();
    }
  }

  void addCustomExcuse(Excuse excuse) {
    _customExcuses.add(excuse);
    notifyListeners();
  }

  void toggleFavorite(Excuse excuse) {
    if (_favorites.any((e) => e.id == excuse.id)) {
      _favorites.removeWhere((e) => e.id == excuse.id);
    } else {
      _favorites.add(excuse);
    }
    notifyListeners();
  }

  List<String> get categories {
    final allCategories = _excuses.map((e) => e.category).toSet().toList();
    allCategories.addAll(_customExcuses.map((e) => e.category).toSet());
    return allCategories.toSet().toList();
  }

  List<Excuse> getHistory() => List.from(_history.reversed);
  List<Excuse> getFavorites() => List.from(_favorites);
  List<Excuse> getCustomExcuses() => List.from(_customExcuses);

  Excuse generateExcuse({String? category}) {
    List<Excuse> possibleExcuses = [];

    if (category != null) {
      possibleExcuses.addAll(
          _excuses.where((excuse) => excuse.category == category).toList());
      possibleExcuses.addAll(_customExcuses
          .where((excuse) => excuse.category == category)
          .toList());
    } else {
      possibleExcuses.addAll(_excuses);
      possibleExcuses.addAll(_customExcuses);
    }

    possibleExcuses.sort((a, b) => b.rating.compareTo(a.rating));
    possibleExcuses.shuffle();

    final selectedExcuse = possibleExcuses.isNotEmpty
        ? possibleExcuses.first
        : Excuse(
            id: _uuid.v4(),
            text: "I don't have an excuse for this",
            category: "General",
          );

    _history.add(selectedExcuse.copyWith(
      usageCount: selectedExcuse.usageCount + 1,
    ));
    notifyListeners();

    return selectedExcuse;
  }
}
