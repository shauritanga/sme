import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sme/src/providers/auth.dart';
import 'package:sme/src/widgets/hex_color.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authService);
    final currentUser = auth.currentUser;

    return Scaffold(
      backgroundColor: HexColor("#102d61"),
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 115,
                      width: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(57.5),
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 2,
                      left: 2,
                      child: Container(
                        height: 111,
                        width: 111,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(57.5),
                          color: HexColor("#102d61"),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      left: 3,
                      child: Container(
                        height: 109,
                        width: 109,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(57.5),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://images.unsplash.com/photo-1561406636-b80293969660?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTM1fHxwZXJzb258ZW58MHx8MHx8fDA%3D",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${currentUser!.displayName}",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      EvaIcons.phoneOutline,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "+255655591660",
                      style: GoogleFonts.roboto(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  ListTile(
                    leading: const Icon(EvaIcons.settingsOutline),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(EvaIcons.lockOutline),
                    title: const Text("Privacy"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(EvaIcons.bellOutline),
                    title: const Text("Notifications"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(EvaIcons.questionMarkCircleOutline),
                    title: const Text("Help & Support"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(EvaIcons.powerOutline),
                    title: const Text("Logout"),
                    onTap: () async {
                      final auth = ref.read(authService);
                      await auth.signOut();

                      // Navigate back to the sign-in screen
                      // ignore: use_build_context_synchronously
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed('/');
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
