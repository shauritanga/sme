import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final purchasesPerWeekProvider = FutureProvider((ref) async {
  final CollectionReference salesCollection =
      FirebaseFirestore.instance.collection('purchases');
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth =
      DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));
  final querySnapshot = await salesCollection
      .where('timestamp', isGreaterThanOrEqualTo: startOfMonth)
      .where('timestamp', isLessThan: endOfMonth)
      .get();

  final result = organizeSalesByWeek(querySnapshot.docs);
  return result;
});

bool isSameWeek(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.weekday == date2.weekday &&
      date1.difference(date2).inDays.abs() <= 6;
}

bool isSameMonth(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month;
}

int numOfWeeks(int year) {
  DateTime dec28 = DateTime(year, 12, 28);
  int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
  return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
}

int getWeekNumber(DateTime date) {
  int dayOfYear = int.parse(DateFormat("D").format(date));
  int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
  if (woy < 1) {
    woy = numOfWeeks(date.year - 1);
  } else if (woy > numOfWeeks(date.year)) {
    woy = 1;
  }
  return woy;
}

Map<String, double> organizeSalesByWeek(List<QueryDocumentSnapshot> sales) {
  Map<String, List<QueryDocumentSnapshot>> weeklySales = {};
  Map<String, double> totalSalesPerWeek = {};

  for (var sale in sales) {
    final saleDate = (sale['timestamp'] as Timestamp).toDate();
    final weekNumber = getWeekNumber(saleDate).toString();

    if (weeklySales.containsKey(weekNumber)) {
      weeklySales[weekNumber]!.add(sale);
    } else {
      weeklySales[weekNumber] = [sale];
    }

    // Calculate total sales for each week
    totalSalesPerWeek[weekNumber] ??= 0.0;
    totalSalesPerWeek[weekNumber] =
        totalSalesPerWeek[weekNumber]! + (sale['cost'] as num).toDouble();
  }

  // Ensure that weeks without sales have a total of zero
// Ensure that weeks without sales have a total of zero
  final allWeeksInMonth =
      List.generate(53, (index) => (index + 1).toString()).where((week) {
    final DateTime firstDayOfYear = DateTime.utc(DateTime.now().year, 1, 1);

    // first day of the year weekday (Monday, Tuesday, etc...)
    final int firstDayOfWeek = firstDayOfYear.weekday;

    // Calculate the number of days to the first day of the week (an offset)
    final int daysToFirstWeek = (8 - firstDayOfWeek) % 7;

    // Get the date of the first day of the week
    final DateTime firstDayOfGivenWeek = firstDayOfYear
        .add(Duration(days: daysToFirstWeek + (int.parse(week) - 1) * 7));

//   Get the last date of the week
    final DateTime lastDayOfGivenWeek =
        firstDayOfGivenWeek.add(const Duration(days: 6));

    return isSameMonth(DateTime.now(), lastDayOfGivenWeek);
  });

  for (var week in allWeeksInMonth) {
    totalSalesPerWeek[week] ??= 0.0;
  }

  return totalSalesPerWeek;
}
