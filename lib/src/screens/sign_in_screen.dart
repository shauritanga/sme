import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sme/src/providers/auth.dart';
import 'package:sme/src/screens/sign_up_screen.dart';
import 'package:sme/src/widgets/hex_color.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 76),
            Image.asset(
              "assets/img/logo_sme.png",
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 36, width: double.infinity),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onSaved: (value) => email = value!,
                      validator: (value) {
                        String pattern =
                            r'^[a-z]+([a-z0-9.-]+)?\@[a-z]+\.[a-z]{2,3}$';
                        RegExp regExp = RegExp(pattern);
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                        if (!regExp.hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Password",
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: "Enter your password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? EvaIcons.eyeOff2Outline
                                : EvaIcons.eyeOutline,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onSaved: (value) => password = value!,
                      validator: (value) {
                        String pattern = r'[A-Za-z]+[0-9]+[.!@#$%*&+~]+';
                        RegExp regExp = RegExp(pattern);
                        // if (!regExp.hasMatch(value!)) {
                        //   return "Password should contains atleast a letter, number and special characters";
                        // } else
                        if (value!.isEmpty) {
                          return "Please enter a password";
                        } else if (value.length < 8) {
                          return "Password should not be less than 8 characters";
                        }
                        return null;
                      },
                      obscureText: hidePassword,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reset');
                  },
                  child: const Text("Forgot password?"),
                ),
              ),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();

                  final auth = ref.read(authService);
                  final result = await showDialog(
                    context: context,
                    builder: (context) => FutureProgressDialog(
                      auth.signInWithEmailPassword(email, password),
                      message: const Text("Loading..."),
                    ),
                  );
                  if (result) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/');
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid email or password"),
                      ),
                    );
                    // Handle sign-in failure, show error message or UI feedback
                  }
                }
              },
              height: 56,
              minWidth: size.width - 32,
              color: HexColor('#102d61'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "LOGIN",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  // HexColor('#f3c44e'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                        (route) => false);
                  },
                  child: const Text("Sign up"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
