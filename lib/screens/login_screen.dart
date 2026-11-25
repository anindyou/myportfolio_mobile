import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      await context.read<AuthState>().login(_username, _password);
      if (!mounted) return;
      Navigator.pop(context, true);
    } on ApiException catch (e) {
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
              'Login failed (${e.statusCode})',
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

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
        title: const Text('Login'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.white,
        scrolledUnderElevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                style: const TextStyle(color: AppColors.white),
                cursorColor: AppColors.purple,
                decoration: _inputDecoration(
                  'Username',
                  hasValue: _username.isNotEmpty,
                ),
                onChanged: (value) => setState(() => _username = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username cannot be empty!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                obscureText: true,
                style: const TextStyle(color: AppColors.white),
                cursorColor: AppColors.purple,
                decoration: _inputDecoration(
                  'Password',
                  hasValue: _password.isNotEmpty,
                ),
                onChanged: (value) => setState(() => _password = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.purple,
                  elevation: 0,
                  minimumSize: const Size(140, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.purple, width: 1.5),
                  ),
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.purple,
                        ),
                      )
                    : const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}