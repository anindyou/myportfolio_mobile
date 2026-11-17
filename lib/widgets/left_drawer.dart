import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/menu.dart';
import 'package:myportfolio_mobile/skill_form.dart'; // asumsi nama file, sesuaikan nanti

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            iconColor: AppColors.green,
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
            iconColor: AppColors.green,
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
        ],
      ),
    );
  }
}