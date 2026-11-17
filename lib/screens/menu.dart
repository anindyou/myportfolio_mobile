import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:myportfolio_mobile/widgets/skill_card.dart';
import 'package:myportfolio_mobile/widgets/info_card.dart';

/// Spacing
class AppSpacing {
  AppSpacing._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
}

/// Color Palette. Mengikuti color style di Figma
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF13111B);
  static const Color pink = Color(0xFFFF79C6);
  static const Color green = Color(0xFF67E480);
  static const Color purple = Color(0xFF988BC7);
  static const Color darkYellow = Color(0xFFFFD700);
  static const Color lightYellow = Color(0xFFE7DE79);
  static const Color white = Color(0xFFD9D9D9);
  static const Color blue = Color(0xFF33C1D5);
  static const Color surface = Color(0xFF1B1827);
  static const Color red = Color(0xFFFF4D66);
}

/// Model data untuk sebuah action button di main page
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String mainTitle = 'MyPortfolio...';
  final String npm = '2506553295';
  final String name = 'Anindya Raihani Hassan';
  final String myClass = 'PBP B';
  final String bio =
      'An undergraduate Computer Science student at Universitas Indonesia '
      'who combines UI/UX design and front-end development to turn raw ideas '
      'into clean, functional, and fully shipped projects.';

  final ItemHomepage viewSkills =
      const ItemHomepage('View Skills', Icons.visibility_outlined, AppColors.green);
  final ItemHomepage addSkill =
      const ItemHomepage('Add Skill', Icons.add, AppColors.green);
  final ItemHomepage viewExperiences =
      const ItemHomepage('View Experiences', Icons.visibility_outlined, AppColors.purple);
  final ItemHomepage addExperience =
      const ItemHomepage('Add Experience', Icons.add, AppColors.purple);
  final ItemHomepage logout =
      const ItemHomepage('Logout', Icons.logout, AppColors.red);

  // Helper function: Membentuk baris berisi 2 ItemHomepage
  // Expanded: card mengisi separuh lebar yang tersedia
  Widget _buildRow(ItemHomepage left, ItemHomepage right) { 
    return Row(
      children: [
        Expanded(child: ItemCard(left)),
        const SizedBox(width: AppSpacing.lg),
        Expanded(child: ItemCard(right)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: SafeArea( // Menghindari area notch dan status bar
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl), // Jarak 24 px di sekeliling seluruh konten dari layar utama
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                mainTitle,
                textAlign: TextAlign.center,
                style: textTheme.titleLarge?.copyWith(
                      color: AppColors.white,
                    ) ??
                    const TextStyle(
                      color: AppColors.white,
                      fontSize: 32,
                    ),
              ),
              const SizedBox(height: AppSpacing.lg),
              InfoCard(title: 'npm', content: npm),
              const SizedBox(height: AppSpacing.sm),
              InfoCard(title: 'name', content: name),
              const SizedBox(height: AppSpacing.sm),
              InfoCard(title: 'class', content: myClass),
              const SizedBox(height: AppSpacing.lg),
              Text(
                bio,
                style: textTheme.bodyLarge?.copyWith(color: AppColors.white) ??
                    const TextStyle(color: AppColors.white, fontSize: 16),
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildRow(viewSkills, addSkill),
              const SizedBox(height: AppSpacing.lg),
              _buildRow(viewExperiences, addExperience),
              const SizedBox(height: AppSpacing.lg),
              ItemCard(logout, horizontal: true),
            ],
          ),
        ),
      ),
    );
  }
}
