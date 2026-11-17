import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:myportfolio_mobile/menu.dart';

class SkillFormPage extends StatefulWidget {
  const SkillFormPage({super.key});

  @override
  State<SkillFormPage> createState() => _SkillFormPageState();
}

class _SkillFormPageState extends State<SkillFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _skillTitle = "";
  String _description = "";
  String _skillIcon = "";


  // Helper function: Dekorasi TextFormField
  InputDecoration _inputDecoration(String label) {
    OutlineInputBorder border(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: color, width: 1.5),
        );

    return InputDecoration(
      hintText: label,
      labelText: label,
      hintStyle: TextStyle(color: AppColors.white.withAlpha(120)),
      labelStyle: const TextStyle(color: AppColors.blue),
      floatingLabelStyle: const TextStyle(color: AppColors.green),
      errorStyle: const TextStyle(color: AppColors.red),
      filled: true,
      fillColor: AppColors.surface,
      border: border(AppColors.blue),
      enabledBorder: border(AppColors.blue),
      focusedBorder: border(AppColors.green),
      errorBorder: border(AppColors.red),
      focusedErrorBorder: border(AppColors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Center(
          child: Text('Add Skill Form'),
        ),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.white,
        scrolledUnderElevation: 0,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Skill Name ===
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: TextFormField(
                  style: const TextStyle(color: AppColors.white),
                  cursorColor: AppColors.green,
                  decoration: _inputDecoration("Skill's title"),
                  onChanged: (String? value) {
                    setState(() {
                      _skillTitle = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Title must be filled!";
                    }
                    return null;
                  },
                ),
              ),
              // === Description ===
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: TextFormField(
                  style: const TextStyle(color: AppColors.white),
                  cursorColor: AppColors.green,
                  decoration: _inputDecoration("Skill's description"),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Description must be filled!";
                    }
                    return null;
                  },
                ),
              ),
              // === Icon ===
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: TextFormField(
                  style: const TextStyle(color: AppColors.white),
                  cursorColor: AppColors.green,
                  decoration: _inputDecoration("Icon Skill"),
                  onChanged: (String? value) {
                    setState(() {
                      _skillIcon = value!;
                    });
                  },
                ),
              ),
              // === Tombol Simpan ===
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.green,
                      elevation: 0,
                      minimumSize: const Size(140, 56),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.md,
                      ),
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                            color: AppColors.green, width: 1.5),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppColors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: const BorderSide(
                                    color: AppColors.green, width: 1.5),
                              ),
                              title: const Text(
                                'Skill is successfully added!',
                                style: TextStyle(color: AppColors.white),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Title: $_skillTitle"),
                                    Text("Description: $_description"),
                                    Text("Icon: $_skillIcon"),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.green,
                                  ),
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text("Save"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}