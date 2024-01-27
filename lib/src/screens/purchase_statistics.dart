import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sme/src/providers/daily_purchase.dart';
import 'package:sme/src/providers/monthly_purchase.dart';
import 'package:sme/src/providers/purchases.dart';
import 'package:sme/src/providers/yearly_purchase.dart';
import 'package:sme/src/widgets/hex_color.dart';

class PurchasesStatistics extends ConsumerStatefulWidget {
  const PurchasesStatistics({
    super.key,
  });

  @override
  ConsumerState<PurchasesStatistics> createState() =>
      _PurchasesStatisticsState();
}

class _PurchasesStatisticsState extends ConsumerState<PurchasesStatistics> {
  int _currentSelectIndex = 0;

  Widget weekBottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thur';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget monthBottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'First';
        break;
      case 1:
        text = 'Second';
        break;
      case 2:
        text = 'Third';
        break;
      case 3:
        text = 'Fourth';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget yearBottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final purchase = ref.watch(purchasesProvider);
    final weekylSalesAsync = ref.watch(dailyPurchasesSummaryProvider);
    final montlySaleAsync = ref.watch(purchasesPerWeekProvider);
    final yearlyAsync = ref.watch(yearlyPurchaseProvider);
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                offset: Offset(1, 2),
                color: Color.fromARGB(255, 209, 208, 208),
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _currentSelectIndex = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _currentSelectIndex == 0
                                ? Colors.blue
                                : HexColor("#d9e3f8"),
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: _currentSelectIndex == 0
                              ? Colors.white
                              : HexColor("#d9e3f8"),
                        ),
                        child: Text(
                          "Weekly",
                          style: TextStyle(
                            color: _currentSelectIndex == 0
                                ? HexColor("#102d61")
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _currentSelectIndex = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _currentSelectIndex == 1
                                ? Colors.blue
                                : HexColor("#d9e3f8"),
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: _currentSelectIndex == 1
                              ? Colors.white
                              : HexColor("#d9e3f8"),
                        ),
                        child: Text(
                          "Monthly",
                          style: TextStyle(
                            color: _currentSelectIndex == 1
                                ? HexColor("#102d61")
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _currentSelectIndex = 2;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _currentSelectIndex == 2
                                ? Colors.blue
                                : HexColor("#d9e3f8"),
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: _currentSelectIndex == 2
                              ? Colors.white
                              : HexColor("#d9e3f8"),
                        ),
                        child: const Text("Yearly"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              [
                weekylSalesAsync.when(
                  error: (error, stackTrace) => Text("$error"),
                  loading: () => const SizedBox(
                    height: 48,
                    width: 48,
                    child: LoadingIndicator(indicatorType: Indicator.ballBeat),
                  ),
                  data: (data) {
                    final total = data.values
                        .toList()
                        .fold(0.0, (prev, ele) => prev + ele);

                    return Column(
                      children: [
                        const Text(
                          "This Week Purchases",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "TSH",
                              style: TextStyle(
                                fontSize: 9,
                                color: HexColor("#102d61"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "$total",
                              style: TextStyle(
                                color: HexColor("#102d61"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 200,
                          child: LineChart(
                            LineChartData(
                              lineTouchData: const LineTouchData(enabled: true),
                              minX: 0,
                              maxX: 6,
                              minY: 0,
                              maxY: 100000,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(0, data['Monday']),
                                    FlSpot(1, data['Tuesday']),
                                    FlSpot(2, data['Wednesday']),
                                    FlSpot(3, data['Thursday']),
                                    FlSpot(4, data['Friday']),
                                    FlSpot(5, data['Saturday']),
                                    FlSpot(6, data['Sunday']),
                                  ],
                                  isCurved: false,
                                  gradient: const LinearGradient(
                                    colors: [Colors.blue, Colors.cyan],
                                  ),
                                  aboveBarData: BarAreaData(
                                    show: true,
                                    color: Colors.transparent,
                                  ),
                                  dotData: const FlDotData(
                                    show: false,
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        HexColor("#d9e3f8"),
                                        HexColor("#d9e3f8"),
                                      ]
                                          .map(
                                              (color) => color.withOpacity(0.5))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                show: true,
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 18,
                                    interval: 1,
                                    getTitlesWidget: weekBottomTitleWidgets,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                montlySaleAsync.when(
                  error: (error, stackTrace) => Text("$error"),
                  loading: () => const SizedBox(
                    height: 48,
                    width: 48,
                    child: LoadingIndicator(indicatorType: Indicator.ballBeat),
                  ),
                  data: (data) {
                    final total = data.values
                        .toList()
                        .fold(0.0, (prev, ele) => prev + ele);

                    return Column(
                      children: [
                        const Text(
                          "This Month Purchases",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "TSH",
                              style: TextStyle(
                                fontSize: 9,
                                color: HexColor("#102d61"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "$total",
                              style: TextStyle(
                                color: HexColor("#102d61"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 200,
                          child: LineChart(
                            LineChartData(
                              lineTouchData: const LineTouchData(enabled: true),
                              minX: 0,
                              maxX: 3,
                              minY: 0,
                              maxY: 5000000,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(0, data["1"]!),
                                    FlSpot(1, data["2"]!),
                                    FlSpot(2, data['3']!),
                                    FlSpot(3, data["4"]!),
                                  ],
                                  isCurved: false,
                                  gradient: const LinearGradient(
                                    colors: [Colors.blue, Colors.cyan],
                                  ),
                                  aboveBarData: BarAreaData(
                                    show: true,
                                    color: Colors.transparent,
                                  ),
                                  dotData: const FlDotData(
                                    show: false,
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        HexColor("#d9e3f8"),
                                        HexColor("#d9e3f8"),
                                      ]
                                          .map(
                                              (color) => color.withOpacity(0.5))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                show: true,
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 18,
                                    interval: 1,
                                    getTitlesWidget: monthBottomTitleWidgets,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                yearlyAsync.when(
                  error: (error, stackTrace) => Text("$error"),
                  loading: () => const SizedBox(
                    height: 48,
                    width: 48,
                    child: LoadingIndicator(indicatorType: Indicator.ballBeat),
                  ),
                  data: (data) {
                    final total = data.values
                        .toList()
                        .fold(0.0, (prev, ele) => prev + ele);

                    return Column(
                      children: [
                        const Text(
                          "This Year Purchases",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "TSH",
                              style: TextStyle(
                                fontSize: 9,
                                color: HexColor("#102d61"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "$total",
                              style: TextStyle(
                                color: HexColor("#102d61"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 200,
                          child: LineChart(
                            LineChartData(
                              lineTouchData: const LineTouchData(enabled: true),
                              minX: 0,
                              maxX: 11,
                              minY: 0,
                              maxY: 10000000,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(0, data["1"]!),
                                    FlSpot(1, data['2']!),
                                    FlSpot(2, data['3']!),
                                    FlSpot(3, data['4']!),
                                    FlSpot(4, data['5']!),
                                    FlSpot(5, data['6']!),
                                    FlSpot(6, data['7']!),
                                    FlSpot(7, data['8']!),
                                    FlSpot(8, data['9']!),
                                    FlSpot(9, data['10']!),
                                    FlSpot(10, data['11']!),
                                    FlSpot(11, data['12']!),
                                  ],
                                  isCurved: false,
                                  gradient: const LinearGradient(
                                    colors: [Colors.blue, Colors.cyan],
                                  ),
                                  aboveBarData: BarAreaData(
                                    show: true,
                                    color: Colors.transparent,
                                  ),
                                  dotData: const FlDotData(
                                    show: false,
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        HexColor("#d9e3f8"),
                                        HexColor("#d9e3f8"),
                                      ]
                                          .map(
                                              (color) => color.withOpacity(0.5))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                show: true,
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 18,
                                    interval: 1,
                                    getTitlesWidget: yearBottomTitleWidgets,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ][_currentSelectIndex],
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Today's purchases",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder(
          future: purchase.getPurchases(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 48,
                width: 48,
                child: LoadingIndicator(
                    indicatorType: Indicator.ballScaleMultiple),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              final todayPurchases = snapshot.data ?? [];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = todayPurchases[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(1, 2),
                            color: Color.fromARGB(255, 209, 208, 208),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item['productName']}",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text("Quantinty:"),
                                  Text("${item['amount']}")
                                ],
                              ),
                              Text(
                                "\$${item['cost']}",
                                style: TextStyle(
                                  color: HexColor("#102d61"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: todayPurchases.length,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              );
            } else {
              return const Text("Something went wrong");
            }
          },
        )
      ],
    );
  }
}
