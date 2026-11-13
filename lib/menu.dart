import 'package:flutter/material.dart';

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
        const SizedBox(width: 12),
        Expanded(child: ItemCard(right)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea( // Menghindari area notch dan status bar
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24), // Jarak 24 px di sekeliling seluruh konten dari layar utama
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
              const SizedBox(height: 16),
              InfoCard(title: 'npm', content: npm),
              const SizedBox(height: 8),
              InfoCard(title: 'name', content: name),
              const SizedBox(height: 8),
              InfoCard(title: 'class', content: myClass),
              const SizedBox(height: 16),
              Text(
                bio,
                style: textTheme.bodyLarge?.copyWith(color: AppColors.white) ??
                    const TextStyle(color: AppColors.white, fontSize: 16),
              ),
              const SizedBox(height: 16),
              _buildRow(viewSkills, addSkill),
              const SizedBox(height: 16),
              _buildRow(viewExperiences, addExperience),
              const SizedBox(height: 16),
              ItemCard(logout, horizontal: true),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            style: textTheme.bodyLarge?.copyWith(color: AppColors.blue) ??
                const TextStyle(color: AppColors.blue, fontSize: 16),
          ),
          const SizedBox(width: 16),
          // Flexible: mencegah teks panjang overflow keluar dari card
          Flexible(
            child: Text(
              content,
              textAlign: TextAlign.end,
              style: textTheme.bodyLarge?.copyWith(color: AppColors.blue) ??
                  const TextStyle(color: AppColors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  final bool horizontal;

  const ItemCard(this.item, {super.key, this.horizontal = false});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    final icon = Icon(item.icon, color: item.color, size: 24);
    final label = Text(
      item.name,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white) ??
          const TextStyle(color: AppColors.white, fontSize: 16),
    );
    
    // DecoratedBox untuk efek glow (BoxShadow) di luar card
    // InkWell untuk ripple effect
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(color: item.color.withAlpha(77), blurRadius: 10),
        ],
      ),
      child: Material(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: item.color, width: 1.5),
        ),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar() // Menutup SnackBar sebelumnya supaya pesan tidak menumpuk
              ..showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                    side: BorderSide(color: item.color, width: 1.5),
                  ),
                  content: Text(
                    "You've clicked ${item.name} button!",
                    style: const TextStyle(color: AppColors.white),
                  ),
                ),
              );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            // horizontal = true -> icon di samping teks (logout)
            // horizontal = false -> icon di atas teks (view / add)
            child: horizontal
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [icon, const SizedBox(width: 12), label],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [icon, const SizedBox(height: 12), label],
                  ),
          ),
        ),
      ),
    );
  }
}