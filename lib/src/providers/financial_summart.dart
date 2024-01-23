import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sme/src/models/dashboard.dart';
import 'package:async/async.dart';

final financialSummaryStreamProvider =
    StreamProvider.autoDispose<Dashboard>((ref) {
  User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  final salesStream = firestore
      .collection('sales')
      .where("userId", isEqualTo: user?.uid)
      .snapshots();
  final purchasesStream = firestore
      .collection('purchases')
      .where("userId", isEqualTo: user?.uid)
      .snapshots();
  final expensesStream = firestore
      .collection('expenses')
      .where("userId", isEqualTo: user?.uid)
      .snapshots();

  final combinedStream =
      StreamZip([salesStream, purchasesStream, expensesStream]);

  return combinedStream
      .asyncMap((List<QuerySnapshot<Object?>> snapshots) async {
    final totalSales = _calculateTotalAmount(snapshots[0]);
    final totalPurchases = _calculateTotalAmount(snapshots[1]);
    final totalExpenses = _calculateTotalAmount(snapshots[2]);

    return Dashboard(
        sales: totalSales,
        purchases: totalPurchases,
        expenses: totalExpenses,
        stock: 657);
  });
});

double _calculateTotalAmount(QuerySnapshot<Object?> snapshot) {
  return snapshot.docs
      .map((doc) => doc['cost'] != null ? (doc['cost'] as num).toDouble() : 0.0)
      .fold(0.0, (acc, amount) => acc + amount);
}