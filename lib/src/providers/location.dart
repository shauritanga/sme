import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getRegions() async {
    final querySnapshot = await _firestore.collection('regions').get();
    return querySnapshot.docs.map((doc) => doc['name'].toString()).toList();
  }

  Future<List<String>> getDistricts(String regionId) async {
    final querySnapshot = await _firestore
        .collection('districts')
        .where('regionId', isEqualTo: regionId)
        .get();
    return querySnapshot.docs.map((doc) => doc['name'].toString()).toList();
  }

  Future<List<String>> getWards(String districtId) async {
    final querySnapshot = await _firestore
        .collection('wards')
        .where('districtId', isEqualTo: districtId)
        .get();
    return querySnapshot.docs.map((doc) => doc['name'].toString()).toList();
  }

  Future<List<String>> getVillages(String wardId) async {
    final querySnapshot = await _firestore
        .collection('villages')
        .where('wardId', isEqualTo: wardId)
        .get();
    return querySnapshot.docs.map((doc) => doc['name'].toString()).toList();
  }
}

final locationServiceProvider =
    Provider<LocationService>((ref) => LocationService());

final regionsProvider = FutureProvider<List<String>>((ref) async {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.getRegions();
});

final districtsProvider =
    FutureProvider.family<List<String>, String>((ref, regionId) async {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.getDistricts(regionId);
});

final wardsProvider =
    FutureProvider.family<List<String>, String>((ref, districtId) async {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.getWards(districtId);
});

final villagesProvider =
    FutureProvider.family<List<String>, String>((ref, wardId) async {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.getVillages(wardId);
});
