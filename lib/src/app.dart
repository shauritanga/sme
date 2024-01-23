import 'package:flutter/material.dart';
import 'package:sme/src/auth_wrapper.dart';
import 'package:sme/src/pages/not_found.dart';
import 'package:sme/src/screens/home.dart';
import 'package:sme/src/screens/rest_password.dart';
import 'package:sme/src/screens/sign_in_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/login': (context) => const SignInScreen(),
        '/home': (context) => const Home(),
        '/reset': (context) => const ResetPasswordScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
      },
    );
  }
}
