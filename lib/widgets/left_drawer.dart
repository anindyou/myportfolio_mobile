import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/screens/skill_form.dart';
import 'package:myportfolio_mobile/screens/experience_form.dart';
import 'package:myportfolio_mobile/screens/login_screen.dart';
import 'package:myportfolio_mobile/widgets/auth_guard.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
    return Drawer(
      backgroundColor: AppColors.background,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                bottom: BorderSide(color: AppColors.blue, width: 1.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal skills and experiences!',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            iconColor: AppColors.blue,
            textColor: AppColors.white,
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            iconColor: AppColors.blue,
            textColor: AppColors.white,
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add skill'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SkillFormPage(),
                ),
              );
            },
          ),
          ListTile(
            iconColor: AppColors.blue,
            textColor: AppColors.white,
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add experience'),
            onTap: () async {
              final ok = await ensureLoggedIn(context);
              if (!ok || !context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExperienceFormPage(),
                ),
              );
            },
          ),
          if (!isLoggedIn)
            ListTile(
              iconColor: AppColors.blue,
              textColor: AppColors.white,
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            )
          else
            ListTile(
              iconColor: AppColors.red,
              textColor: AppColors.white,
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                final auth = context.read<AuthState>();
                Navigator.pop(context);
                await auth.logout();
              },
            ),
        ],
      ),
    );
  }
}