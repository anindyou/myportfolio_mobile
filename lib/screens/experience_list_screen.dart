import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myportfolio_mobile/models/experience.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:myportfolio_mobile/screens/experience_detail_screen.dart';
import 'package:provider/provider.dart';

class ExperienceListScreen extends StatefulWidget {
  const ExperienceListScreen({super.key});

  @override
  State<ExperienceListScreen> createState() => _ExperienceListScreenState();
}

class _ExperienceListScreenState extends State<ExperienceListScreen> {
  late Future<List<Experience>> _experiencesFuture;
  final _dateFmt = DateFormat('MMM yyyy');

  @override
  void initState() {
    super.initState();
    _experiencesFuture = context.read<ApiClient>().getExperiences();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getExperiences();
    setState(() {
      _experiencesFuture = future;
    });
    await future;
  }

  String _period(Experience e) =>
      '${_dateFmt.format(e.startedAt)} - ${e.endedAt == null ? 'Present' : _dateFmt.format(e.endedAt!)}';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Experiences'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.white,
        scrolledUnderElevation: 0,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Experience>>(
        future: _experiencesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.purple),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Failed to load experiences: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.red),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        foregroundColor: AppColors.purple,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: AppColors.purple,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final experiences = snapshot.data ?? const <Experience>[];

          if (experiences.isEmpty) {
            return RefreshIndicator(
              color: AppColors.purple,
              onRefresh: _reload,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Center(
                    child: Text(
                      'No experiences found.',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.purple,
            onRefresh: _reload,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: experiences.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final e = experiences[index];
                final institution = e.institution;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.purple.withAlpha(77),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Material(
                    color: AppColors.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: AppColors.purple,
                        width: 1.5,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                ExperienceDetailScreen(experience: e),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.title,
                              style: textTheme.bodyLarge?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (institution != null &&
                                institution.isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                institution,
                                style: const TextStyle(color: AppColors.purple),
                              ),
                            ],
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              _period(e),
                              style: const TextStyle(color: AppColors.blue),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              e.description,
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
