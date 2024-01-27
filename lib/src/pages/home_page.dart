import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sme/src/providers/financial_summart.dart';
import 'package:sme/src/screens/expenses_screen.dart';
import 'package:sme/src/screens/purchase_screen.dart';
import 'package:sme/src/screens/sales_screen.dart';
import 'package:sme/src/widgets/custom_card.dart';
import 'package:sme/src/widgets/hex_color.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final asyncValue =
        ref.watch(financialSummaryStreamProvider.select((value) => value));
    return asyncValue.when(
      error: (error, stackTrace) => Text("$error"),
      loading: () => Center(
          child: SizedBox(
        height: 48,
        width: 48,
        child: LoadingIndicator(
          indicatorType: Indicator.ballScaleMultiple,
          colors: [HexColor("#102d61")],
        ),
      )),
      data: (data) => Scaffold(
        appBar: AppBar(
          title: const Text("Overview"),
          centerTitle: false,
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                  color: HexColor("#d9e3f8"),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(DateFormat.yMMMMd().format(DateTime.now())),
            ),
          ],
        ),
        backgroundColor: HexColor("#fdfdfd"),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.black26),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 35,
                          sections: [
                            PieChartSectionData(
                              title:
                                  "${((data.purchases / data.total) * 100).toStringAsFixed(0)}%",
                              value: data.purchases,
                              radius: 50,
                              color: HexColor("#102d61").withAlpha(180),
                              titleStyle: const TextStyle(color: Colors.white),
                            ),
                            PieChartSectionData(
                              title:
                                  "${((data.sales / data.total) * 100).toStringAsFixed(0)}%",
                              value: data.sales,
                              radius: 50,
                              color: HexColor("#102d61"),
                              titleStyle: const TextStyle(color: Colors.white),
                            ),
                            PieChartSectionData(
                              title:
                                  "${((data.expenses / data.total) * 100).toStringAsFixed(0)}%",
                              value: data.expenses,
                              radius: 50,
                              color: HexColor("#f6c347"),
                              titleStyle: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                color: HexColor("#102d61"),
                              ),
                              const SizedBox(width: 6),
                              const Text("Sales")
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                color: HexColor("#102d61").withAlpha(180),
                              ),
                              const SizedBox(width: 6),
                              const Text("Purchases")
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                color: HexColor("#f6c347"),
                              ),
                              const SizedBox(width: 6),
                              const Text("Expenses")
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        value: Row(
                          children: [
                            const Text(
                              "TSH",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              data.sales.toStringAsFixed(2),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SalesScreen(),
                            ),
                          );
                        },
                        title: "TOTAL SALES",
                        titleStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        icon: EvaIcons.clockOutline,
                        color: HexColor("#102d61"),
                        iconBackgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomCard(
                        value: Row(
                          children: [
                            const Text(
                              "TSH",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              data.purchases.toStringAsFixed(2),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PurchaseScreen(),
                            ),
                          );
                        },
                        icon: EvaIcons.creditCardOutline,
                        iconBackgroundColor: Colors.cyanAccent,
                        color: HexColor("#102d61").withAlpha(180),
                        title: "TOTAL PURCHASES",
                        titleStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        value: Row(
                          children: [
                            const Text(
                              "TSH",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              data.expenses.toStringAsFixed(2),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        topTitleStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        title: "TOTAL EXPENSES",
                        titleStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        icon: Icons.currency_pound_outlined,
                        iconBackgroundColor: HexColor("efeaea"),
                        iconColor: HexColor("#151d26"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ExpensesScreen(),
                            ),
                          ).then(
                            (value) => setState(
                              () {},
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomCard(
                        icon: EvaIcons.shoppingBagOutline,
                        iconBackgroundColor: HexColor("efeaea"),
                        iconColor: HexColor("#151d26"),
                        title: "CURRENT STOCK",
                        titleStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        value: Text("${data.stock}"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
