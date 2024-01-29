import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sme/src/providers/auth.dart';
import 'package:sme/src/widgets/hex_color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  UploadTask? uploadTask;

  Future uploadProfileImage(File file, XFile? pickedImage) async {
    User? user = FirebaseAuth.instance.currentUser;
    final path = "images/${user?.uid}/${pickedImage!.name}";
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      ref.putFile(file);
    } catch (e) {
      throw Exception("File upload failed");
    }

    setState(() {
      uploadTask = ref.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(urlDownload);
  }

  Future<void> _launchUrl(String phone) async {
    Uri uri = Uri(path: phone, scheme: "tel");
    if (!await launchUrl(uri)) {
      throw Exception("Could not launch $phone");
    }
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(currentUser!
                                        .photoURL ==
                                    null
                                ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQofHJFmvUkoZgk9cHJsB5XrkMGy2W-qIiCqkIhXWv3e1GkxA_N2mfS&usqp=CAE&s"
                                : "${currentUser.photoURL}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 74,
                      left: 80,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: size.height * 0.15,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            ImagePicker imagePicker =
                                                ImagePicker();
                                            XFile? pickedImage =
                                                await imagePicker.pickImage(
                                                    source: ImageSource.camera);
                                            File image =
                                                File(pickedImage!.path);
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            await uploadProfileImage(
                                                image, pickedImage);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          },
                                          child: const ImageFrom(
                                            from: "Camera",
                                            icon: Icons.camera_alt,
                                          ),
                                        ),
                                        const SizedBox(width: 32),
                                        InkWell(
                                          onTap: () async {
                                            ImagePicker imagePicker =
                                                ImagePicker();
                                            XFile? pickedImage =
                                                await imagePicker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            File image =
                                                File(pickedImage!.path);
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            await uploadProfileImage(
                                                image, pickedImage);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          },
                                          child: const ImageFrom(
                                            from: "Gallery",
                                            icon: Icons.image_sharp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 34,
                          width: 34,
                          decoration: BoxDecoration(
                              color: HexColor("#102d61"),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${currentUser.displayName}",
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
                      EvaIcons.emailOutline,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "${currentUser.email}",
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
                  // ListTile(
                  //   leading: const Icon(EvaIcons.settingsOutline),
                  //   title: const Text("Settings"),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (_) => const SettingScreen()));
                  //   },
                  // ),
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
                    onTap: () {
                      _launchUrl("+255655591660");
                    },
                  ),
                  ListTile(
                    leading: const Icon(EvaIcons.powerOutline),
                    title: const Text("Logout"),
                    onTap: () async {
                      final auth = ref.read(authService);
                      await auth.signOut();
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

class ImageFrom extends StatelessWidget {
  final String from;
  final IconData icon;
  const ImageFrom({
    required this.from,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: HexColor("#102d61").withOpacity(0.8),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(from),
      ],
    );
  }
}
