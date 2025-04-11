class Excuse {
  final String id;
  final String text;
  final String category;
  final bool isFavorite;
  final DateTime createdAt;
  final int usageCount;
  final double rating;
  final bool isCustom;
  final String? creatorName;

  Excuse({
    required this.id,
    required this.text,
    required this.category,
    this.isFavorite = false,
    DateTime? createdAt,
    this.usageCount = 0,
    this.rating = 0.0,
    this.isCustom = false,
    this.creatorName,
  }) : createdAt = createdAt ?? DateTime.now();

  Excuse copyWith({
    String? id,
    String? text,
    String? category,
    bool? isFavorite,
    DateTime? createdAt,
    int? usageCount,
    double? rating,
    bool? isCustom,
    String? creatorName,
  }) {
    return Excuse(
      id: id ?? this.id,
      text: text ?? this.text,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      usageCount: usageCount ?? this.usageCount,
      rating: rating ?? this.rating,
      isCustom: isCustom ?? this.isCustom,
      creatorName: creatorName ?? this.creatorName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'category': category,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
      'usageCount': usageCount,
      'rating': rating,
      'isCustom': isCustom,
      'creatorName': creatorName,
    };
  }

  factory Excuse.fromMap(Map<String, dynamic> map) {
    return Excuse(
      id: map['id'],
      text: map['text'],
      category: map['category'],
      isFavorite: map['isFavorite'],
      createdAt: DateTime.parse(map['createdAt']),
      usageCount: map['usageCount'],
      rating: map['rating'],
      isCustom: map['isCustom'],
      creatorName: map['creatorName'],
    );
  }
}