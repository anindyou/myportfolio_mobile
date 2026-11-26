import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:intl/intl.dart';

import 'package:myportfolio_mobile/widgets/auth_guard.dart';
import 'package:myportfolio_mobile/models/experience.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _experienceTitle = "";
  String _description = "";
  String _institution = "";
  DateTime? _startedAt;
  DateTime? _endedAt;
  final _startedAtCtrl = TextEditingController();
  final _endedAtCtrl = TextEditingController();
  final _dateFmt = DateFormat('MMM yyyy');

  @override
  void dispose() {
    _startedAtCtrl.dispose();
    _endedAtCtrl.dispose();
    super.dispose();
  }

  // Membuka dialog pemilih tanggal tanggal Flutter
  Future<DateTime?> _pickDate(DateTime? initial) => showDatePicker(
    context: context,
    initialDate: initial ?? DateTime.now(), // null kalau user tidak memilih
    firstDate: DateTime(1970),
    lastDate: DateTime(2100),
    initialDatePickerMode: DatePickerMode.year,
  );

  String get _period =>
      '${_dateFmt.format(_startedAt!)} - ${_endedAt == null ? 'Present' : _dateFmt.format(_endedAt!)}';

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final ok = await ensureLoggedIn(context);
    if (!ok || !mounted) return;

    final auth = context.read<AuthState>();
    final token = auth.token!;

    final newExperience = Experience(
      title: _experienceTitle,
      institution: _institution,
      description: _description,
      startedAt: _startedAt!,
      endedAt: _endedAt,
    );

    try {
      await context.read<ApiClient>().createExperience(
        newExperience,
        token: token,
      );
      if (!mounted) return;
      _showSuccessDialog();
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        await auth.logout();
        if (!mounted) return;
        await ensureLoggedIn(context);
        return;
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.red, width: 1.5),
            ),
            content: Text(
              'Failed to save experience (${e.statusCode})',
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        );
    }
  }

  void _showSuccessDialog() {
    final period = _period;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.purple, width: 1.5),
          ),
          title: const Text(
            'Experience is successfully added!',
            style: TextStyle(color: AppColors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title: $_experienceTitle"),
                Text("Institution: $_institution"),
                Text("Description: $_description"),
                Text("Period: $period"),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: AppColors.purple),
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                _formKey.currentState!.reset();
                setState(() {
                  _experienceTitle = "";
                  _institution = "";
                  _description = "";
                  _startedAt = null;
                  _endedAt = null;
                  _startedAtCtrl.clear();
                  _endedAtCtrl.clear();
                });
              },
            ),
          ],
        );
      },
    );
  }

  // Helper function: Dekorasi TextFormField
  InputDecoration _inputDecoration(String label, {bool hasValue = false}) {
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: 1.5),
    );

    return InputDecoration(
      hintText: label,
      labelText: label,
      hintStyle: TextStyle(color: AppColors.white.withAlpha(120)),
      labelStyle: const TextStyle(color: AppColors.white),
      floatingLabelStyle: const TextStyle(color: AppColors.purple),
      errorStyle: const TextStyle(color: AppColors.red),
      filled: true,
      fillColor: AppColors.surface,
      border: border(AppColors.purple),
      enabledBorder: border(hasValue ? AppColors.purple : AppColors.white),
      focusedBorder: border(AppColors.purple),
      errorBorder: border(AppColors.red),
      focusedErrorBorder: border(AppColors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Center(child: Text('Add Experience Form')),
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
              // === Experience Name ===
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: TextFormField(
                  style: const TextStyle(color: AppColors.white),
                  cursorColor: AppColors.purple,
                  decoration: _inputDecoration(
                    "Experience's title",
                    hasValue: _experienceTitle.trim().isNotEmpty,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _experienceTitle = value!;
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
              // === Institution ===
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: TextFormField(
                  style: const TextStyle(color: AppColors.white),
                  cursorColor: AppColors.purple,
                  decoration: _inputDecoration(
                    "Institution's name",
                    hasValue: _institution.trim().isNotEmpty,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _institution = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Institution's name must be filled!";
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
                  cursorColor: AppColors.purple,
                  decoration: _inputDecoration(
                    "Experience's description",
                    hasValue: _description.trim().isNotEmpty,
                  ),
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
              // === Started at ===
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: TextFormField(
                  controller: _startedAtCtrl,
                  readOnly: true,
                  style: const TextStyle(color: AppColors.white),
                  decoration: _inputDecoration(
                    "Started at",
                    hasValue: _startedAt != null,
                  ),
                  onTap: () async {
                    final picked = await _pickDate(_startedAt);
                    if (picked != null) {
                      setState(() {
                        _startedAt = picked;
                        _startedAtCtrl.text = _dateFmt.format(picked);
                      });
                    }
                  },
                  validator: (_) =>
                      _startedAt == null ? "Start date must be filled!" : null,
                ),
              ),
              // === Ended at (optional) ===
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: TextFormField(
                  controller: _endedAtCtrl,
                  readOnly: true,
                  style: const TextStyle(color: AppColors.white),
                  decoration: _inputDecoration(
                    "Ended at (optional)",
                    hasValue: _endedAt != null,
                  ),
                  onTap: () async {
                    final picked = await _pickDate(_endedAt ?? _startedAt);
                    if (picked != null) {
                      setState(() {
                        _endedAt = picked;
                        _endedAtCtrl.text = _dateFmt.format(picked);
                      });
                    }
                  },
                  validator: (_) {
                    if (_endedAt != null &&
                        _startedAt != null &&
                        _endedAt!.isBefore(_startedAt!)) {
                      return "End date can't be before start date!";
                    }
                    return null;
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
                      foregroundColor: AppColors.purple,
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
                          color: AppColors.purple,
                          width: 1.5,
                        ),
                      ),
                    ),
                    onPressed: _submit,
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
