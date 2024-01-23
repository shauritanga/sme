import 'package:flutter/material.dart';
import 'package:sme/src/widgets/graph_card.dart';

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
            Center(child: Text("under construction")),
            Center(child: Text("under construction")),
          ],
        ),
      ),
    );
  }
}
