import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final purchasesProvider = Provider<Purchases>((ref) => Purchases());

class Purchases {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference _salesCollection =
      FirebaseFirestore.instance.collection('purchases');

  Future<bool> addPurchase(
      String productName, double amount, double price) async {
    final result = await _salesCollection.add({
      'productName': productName,
      'amount': amount,
      "cost": amount * price,
      "userId": user?.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });
    if (result.id.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getPurchasess() async {
    final querySnapshot = await _salesCollection
        .where("userId", isEqualTo: user?.uid)
        .where("timestamp", isGreaterThanOrEqualTo: _startOfToday())
        .where("timestamp", isLessThan: _startOfTomorrow())
        .get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> updateSale(
      String saleId, String newProductName, double newAmount) async {
    await _salesCollection.doc(saleId).update({
      'productName': newProductName,
      'amount': newAmount,
    });
  }

  Future<void> deleteSale(String saleId) async {
    await _salesCollection.doc(saleId).delete();
  }

  DateTime _startOfToday() {
    DateTime now = DateTime.now();

    return DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
  }

  // Helper method to get the start of tomorrow
  DateTime _startOfTomorrow() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day + 1, 0, 0, 0, 0);
  }
}
