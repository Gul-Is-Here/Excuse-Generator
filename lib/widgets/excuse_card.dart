import 'package:flutter/material.dart';
import 'package:excuse_generator/models/excuse.dart';
import 'package:google_fonts/google_fonts.dart';

class ExcuseCard extends StatelessWidget {
  final Excuse excuse;
  final bool isFavorite;
  final VoidCallback? onRate;
  final VoidCallback? onGenerateNew;

  const ExcuseCard({
    super.key,
    required this.excuse,
    this.isFavorite = false,
    this.onRate,
    this.onGenerateNew,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    excuse.category,
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (excuse.rating > 0)
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        excuse.rating.toStringAsFixed(1),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              excuse.text,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (onRate != null)
                  TextButton.icon(
                    onPressed: onRate,
                    icon: const Icon(Icons.star_border),
                    label: const Text('Rate'),
                  ),
                const Spacer(),
                if (onGenerateNew != null)
                  TextButton.icon(
                    onPressed: onGenerateNew,
                    icon: const Icon(Icons.autorenew),
                    label: const Text('New'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}