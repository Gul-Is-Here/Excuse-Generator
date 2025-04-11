import 'package:flutter/material.dart';
import 'package:excuse_generator/models/excuse.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingDialog extends StatelessWidget {
  final Excuse excuse;
  final ValueChanged<double> onRatingSubmitted;

  const RatingDialog({
    super.key,
    required this.excuse,
    required this.onRatingSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    double rating = excuse.rating;

    return AlertDialog(
      title: const Text('Rate this excuse'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            excuse.text,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          RatingBar.builder(
            initialRating: rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (newRating) {
              rating = newRating;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onRatingSubmitted(rating);
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}