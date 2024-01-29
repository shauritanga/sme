import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final dailyPurchasesSummaryProvider = FutureProvider.autoDispose((ref) async {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference salesCollection =
      FirebaseFirestore.instance.collection('purchases');

  final now = DateTime.now();
  final startOfWeek = DateTime(now.year, now.month, now.day - now.weekday);
  final endOfWeek = startOfWeek.add(const Duration(days: 7));
  final querySnapshot = await salesCollection
      .where("userId", isEqualTo: user?.uid)
      .where("timestamp", isGreaterThanOrEqualTo: startOfWeek)
      .where("timestamp", isLessThan: endOfWeek)
      .get();

  final result = calculateDailySalesSummary(querySnapshot.docs, startOfWeek);
  return result;
});

Map<String, dynamic> calculateDailySalesSummary(
    List<DocumentSnapshot> sales, DateTime startOfWeek) {
  Map<String, double> dailySalesSummary = {};

  // Initialize the dailySalesSummary map with all days in the week
  for (int i = 0; i < 7; i++) {
    final day = startOfWeek.add(Duration(days: i));
    final dayKey =
        DateFormat('EEEE').format(day); // Format to the day of the week
    dailySalesSummary[dayKey] = 0.0;
  }

  // Populate the map with actual sales data
  for (var sale in sales) {
    final saleDate = (sale['timestamp'] as Timestamp).toDate();
    final origin = sale.data() as Map;
    final dayKey =
        DateFormat('EEEE').format(saleDate); // Format to the day of the week

    dailySalesSummary[dayKey] =
        dailySalesSummary[dayKey]! + (origin['cost'] as num).toDouble();
  }

  return dailySalesSummary;
}
