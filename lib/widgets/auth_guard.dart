import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/login_screen.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

/// Ensures the user is authenticated, pushing [LoginScreen] when needed.
Future<bool> ensureLoggedIn(BuildContext context) async {
  // TODO: If context.read<AuthState>().isLoggedIn is true, return true immediately.
  // Otherwise push LoginScreen with Navigator.push<bool>(...) and return loggedIn ?? false.
  throw UnimplementedError();
}