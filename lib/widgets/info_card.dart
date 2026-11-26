import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/menu.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blue, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '> $title',
            style:
                textTheme.bodyLarge?.copyWith(color: AppColors.blue) ??
                const TextStyle(color: AppColors.blue, fontSize: 16),
          ),
          const SizedBox(width: AppSpacing.lg),
          // Flexible: mencegah teks panjang overflow keluar dari card
          Flexible(
            child: Text(
              content,
              textAlign: TextAlign.end,
              style:
                  textTheme.bodyLarge?.copyWith(color: AppColors.blue) ??
                  const TextStyle(color: AppColors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
