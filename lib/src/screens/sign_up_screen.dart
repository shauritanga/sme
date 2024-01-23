import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sme/src/providers/auth.dart';
import 'package:sme/src/providers/location.dart';
import 'package:sme/src/screens/sign_in_screen.dart';
import 'package:sme/src/widgets/hex_color.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedRegion;
  String? selectedRegionId;
  String? selectedDistrict;
  String? selectedDistrictId;
  String? selectedWard;
  String? selectedVillage;
  String? selectedWardId;
  String name = "";
  String region = "";
  String district = "";
  String ward = "";
  String village = "";
  String email = "";
  String password = "";
  String phone = "";

  Stream<QuerySnapshot> getRegions() {
    return _firestore.collection('regions').snapshots();
  }

  Stream<QuerySnapshot> getDistricts(String regionId) {
    return _firestore
        .collection('districts')
        .where('regionId', isEqualTo: regionId)
        .snapshots();
  }

  Stream<QuerySnapshot> getWards(String districtId) {
    return _firestore
        .collection('wards')
        .where('districtId', isEqualTo: districtId)
        .snapshots();
  }

  Stream<QuerySnapshot> getVillages(String wardId) {
    return _firestore
        .collection('villages')
        .where('wardId', isEqualTo: wardId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final regionAsyncValue = ref.watch(regionsProvider);
    regionAsyncValue.whenData(
      (value) => value,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 36, width: double.infinity),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your full name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onSaved: (value) => name = value!,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Location",
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    StreamBuilder<QuerySnapshot>(
                      stream: getRegions(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        // List<String> regions = snapshot.data!.docs
                        //     .map((doc) => doc['name'].toString())
                        //     .toList();

                        List<QueryDocumentSnapshot> regions =
                            snapshot.data!.docs;
                        List<Map> mikoa = regions.map((mkoa) {
                          return {"id": mkoa.id, "name": mkoa.data() as Map};
                        }).toList();

                        return DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text('Select Region'),
                                value: selectedRegion,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedRegionId = mikoa
                                        .where((element) =>
                                            element['name']['name'] == value)
                                        .first['id']
                                        .toString();
                                    selectedRegion = value;
                                    selectedDistrict = null;
                                    selectedWard = null;
                                  });
                                },
                                items: mikoa.map((region) {
                                  return DropdownMenuItem<String>(
                                    value: region['name']['name'],
                                    child: Text("${region['name']['name']}"),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    StreamBuilder<QuerySnapshot>(
                      stream: selectedRegion != null
                          ? getDistricts(selectedRegionId!)
                          : null,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || selectedRegion == null) {
                          return Container();
                        }

                        List<QueryDocumentSnapshot> districts =
                            snapshot.data!.docs;

                        List<Map> wilayas = districts.map((mkoa) {
                          return {"id": mkoa.id, "name": mkoa.data() as Map};
                        }).toList();

                        return DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text('Select District'),
                                value: selectedDistrict,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedDistrictId = wilayas
                                        .where((element) =>
                                            element['name']['name'] == value)
                                        .first['id']
                                        .toString();
                                    selectedDistrict = value;
                                    selectedWard = null;
                                  });
                                },
                                items: wilayas.map((district) {
                                  return DropdownMenuItem<String>(
                                    value: district['name']['name'],
                                    child: Text("${district['name']['name']}"),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    StreamBuilder<QuerySnapshot>(
                      stream: selectedDistrict != null
                          ? getWards(selectedDistrictId!)
                          : null,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || selectedDistrict == null) {
                          return Container();
                        }

                        // List<String> wards = snapshot.data.docs
                        //     .map((doc) => doc['name'].toString())
                        //     .toList();

                        List<QueryDocumentSnapshot> wards = snapshot.data!.docs;

                        List<Map> katas = wards.map((kata) {
                          return {"id": kata.id, "name": kata.data() as Map};
                        }).toList();
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text('Select Ward'),
                                value: selectedWard,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedWardId = katas
                                        .where((element) =>
                                            element['name']['name'] == value)
                                        .first['id']
                                        .toString();
                                    selectedWard = value;
                                  });
                                },
                                items: katas.map((ward) {
                                  return DropdownMenuItem<String>(
                                    value: ward['name']['name'],
                                    child: Text("${ward['name']['name']}"),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    StreamBuilder<QuerySnapshot>(
                      stream: selectedWard != null
                          ? getVillages(selectedWardId!)
                          : null,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || selectedWard == null) {
                          return Container();
                        }

                        List<String> villages = snapshot.data!.docs
                            .map((doc) => doc['name'].toString())
                            .toList();

                        return DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text('Select Village'),
                                value: selectedVillage,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedVillage = value;
                                  });
                                },
                                items: villages.map((String village) {
                                  return DropdownMenuItem<String>(
                                    value: village,
                                    child: Text(village),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
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
                      "Phone",
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onSaved: (value) => phone = value!,
                      validator: (value) {
                        return null;
                      },
                      keyboardType: TextInputType.phone,
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
                          hintText: "Enter your password"),
                      onSaved: (value) => password = value!,
                      validator: (value) {
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            MaterialButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();

                  if (selectedRegion == null ||
                      selectedDistrict == null ||
                      selectedWard == null ||
                      selectedVillage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please select your location"),
                    ));
                    return;
                  }
                  Map<String, dynamic> data = {
                    "name": name,
                    "region": selectedRegion!,
                    "district": selectedDistrict!,
                    "ward": selectedWard!,
                    "village": selectedVillage!,
                    "email": email,
                    "password": password,
                    "phone": phone,
                  };

                  final auth = ref.read(authService);
                  final result = await showDialog(
                    context: context,
                    builder: (context) => FutureProgressDialog(
                      auth.signUpWithEmailPassword(data),
                      message: const Text("Loading..."),
                    ),
                  );
                  //final result = await auth.signUpWithEmailPassword(data);
                  if (result) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/');
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
                "REGISTER",
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
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignInScreen(),
                        ),
                        (route) => false);
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:'),
        DropdownButton<String>(
          hint: Text('Select $title'),
          value: null,
          onChanged: (String? value) {},
          items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              })?.toList() ??
              [],
        ),
      ],
    );
  }
}
