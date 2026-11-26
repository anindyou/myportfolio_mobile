import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/screens/skill_form.dart';
import 'package:myportfolio_mobile/screens/experience_form.dart';
import 'package:myportfolio_mobile/screens/experience_list_screen.dart';
import 'package:myportfolio_mobile/widgets/auth_guard.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

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
      style:
          Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: AppColors.white) ??
          const TextStyle(color: AppColors.white, fontSize: 16),
    );

    // DecoratedBox untuk efek glow (BoxShadow) di luar card
    // InkWell untuk ripple effect
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [BoxShadow(color: item.color.withAlpha(77), blurRadius: 10)],
      ),
      child: Material(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: item.color, width: 1.5),
        ),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () async {
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
            if (item.name == "Add Skill") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SkillFormPage()),
              );
            } else if (item.name == "Add Experience") {
              final ok = await ensureLoggedIn(context);
              if (!ok || !context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExperienceFormPage(),
                ),
              );
            } else if (item.name == "View Experiences") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExperienceListScreen(),
                ),
              );
            } else if (item.name == "Logout") {
              await context.read<AuthState>().logout();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            // horizontal = true -> icon di samping teks (logout)
            // horizontal = false -> icon di atas teks (view / add)
            child: horizontal
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      const SizedBox(width: AppSpacing.sm),
                      label,
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      icon,
                      const SizedBox(height: AppSpacing.sm),
                      label,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
