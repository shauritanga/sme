import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sme/src/providers/auth.dart';
import 'package:sme/src/screens/home.dart';
import 'package:sme/src/screens/sign_in_screen.dart';

final authStateProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(authService).authStateChanges();
});

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (state) {
        switch (state) {
          case AuthState.authenticated:
            return const Home();
          case AuthState.unauthenticated:
            return const SignInScreen();
          case AuthState.loading:
            // You might want to show a loading indicator here
            return const CircularProgressIndicator();
        }
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) {
        // Handle error here
        print("Error: $error");
        return const Text("Error occurred. Please try again.");
      },
    );
  }
}
