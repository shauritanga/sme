import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final yearlyExpenseProvider = FutureProvider((ref) async {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();
  QuerySnapshot querySnapshot = await firestore
      .collection('expenses')
      .where("userId", isEqualTo: user?.uid)
      .where('timestamp', isGreaterThanOrEqualTo: DateTime(now.year, 1, 1))
      .where('timestamp', isLessThan: DateTime(now.year + 1, 1, 1))
      .get();

  Map<String, double> monthlySales = {};

  // Update total sales for each month based on actual sales data
  for (var doc in querySnapshot.docs) {
    DateTime saleDate = doc['timestamp'].toDate();
    int month = saleDate.month;
    final amount = doc['cost'];

    // Add the current amount to the existing total
    monthlySales[month.toString()] =
        (monthlySales[month.toString()] ?? 0.0) + amount;
  }

  // Ensure months with no sales have a total of zero
  for (int month = 1; month <= 12; month++) {
    monthlySales[month.toString()] = monthlySales[month.toString()] ?? 0.0;
  }
  return monthlySales;
});
