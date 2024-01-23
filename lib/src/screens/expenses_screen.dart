import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sme/src/providers/expenses.dart';
import 'package:sme/src/screens/add_item_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
      ),
      body: FutureBuilder(
        future: expenses.getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final response = snapshot.data ?? [];
          final expenses = response.reversed.toList();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final sale = expenses[index];
                DateTime created = sale['timestamp'].toDate();
                final difference = DateTime.now().difference(created);
                final now = DateTime.now();
                final timeAgo = timeago.format(now.subtract(difference));

                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${sale['productName']}"),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                EvaIcons.clockOutline,
                                color: Colors.grey,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                timeAgo,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //actions
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              EvaIcons.edit2Outline,
                              color: Colors.black.withAlpha(200),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              EvaIcons.trash2Outline,
                              color: Colors.red.withAlpha(200),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: expenses.length,
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddItemScreen(
                title: "Add new expense",
                type: "expenses",
              ),
            ),
          );
        },
        child: const Icon(EvaIcons.plus),
      ),
    );
  }
}
