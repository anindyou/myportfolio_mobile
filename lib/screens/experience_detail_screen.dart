import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myportfolio_mobile/models/experience.dart';
import 'package:myportfolio_mobile/screens/menu.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({super.key, required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateFmt = DateFormat('MMM yyyy');
    final institution = experience.institution;
    final end = experience.endedAt == null
        ? 'Present'
        : dateFmt.format(experience.endedAt!);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Experience Detail'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: AppColors.purple.withAlpha(77), blurRadius: 10),
            ],
          ),
          child: Material(
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.purple, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience.title,
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColors.white,
                      fontSize: 24,
                    ),
                  ),
                  if (institution != null && institution.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      institution,
                      style: const TextStyle(color: AppColors.purple),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '${dateFmt.format(experience.startedAt)} - $end',
                    style: const TextStyle(color: AppColors.blue),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    experience.description,
                    style: const TextStyle(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
