import 'package:flutter/material.dart';
import 'package:sme/src/screens/expense_statistics.dart';
import 'package:sme/src/screens/purchase_statistics.dart';
import 'package:sme/src/screens/sale_statistics.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Statistics"),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Sales",
              ),
              Tab(
                text: "Purchases",
              ),
              Tab(
                text: "Expenses",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SalesStatistics(),
            PurchasesStatistics(),
            ExpensesStatistics(),
          ],
        ),
      ),
    );
  }
}
